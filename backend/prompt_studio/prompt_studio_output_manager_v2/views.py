import logging
from typing import Any

from django.core.exceptions import ObjectDoesNotExist
from django.db.models import QuerySet
from django.http import HttpRequest
from rest_framework import status, viewsets
from rest_framework.exceptions import APIException
from rest_framework.response import Response
from rest_framework.versioning import URLPathVersioning
from utils.common_utils import CommonUtils
from utils.filtering import FilterHelper

from prompt_studio.prompt_studio_output_manager_v2.constants import (
    PromptOutputManagerErrorMessage,
    PromptStudioOutputManagerKeys,
)
from prompt_studio.prompt_studio_output_manager_v2.output_manager_helper import (
    OutputManagerHelper,
)
from prompt_studio.prompt_studio_output_manager_v2.serializers import (
    PromptStudioOutputSerializer,
)
from prompt_studio.prompt_studio_v2.models import ToolStudioPrompt

from .models import PromptStudioOutputManager

logger = logging.getLogger(__name__)


class PromptStudioOutputView(viewsets.ModelViewSet):
    versioning_class = URLPathVersioning
    serializer_class = PromptStudioOutputSerializer

    def get_queryset(self) -> QuerySet | None:
        filter_args = FilterHelper.build_filter_args(
            self.request,
            PromptStudioOutputManagerKeys.TOOL_ID,
            PromptStudioOutputManagerKeys.PROMPT_ID,
            PromptStudioOutputManagerKeys.PROFILE_MANAGER,
            PromptStudioOutputManagerKeys.DOCUMENT_MANAGER,
            PromptStudioOutputManagerKeys.IS_SINGLE_PASS_EXTRACT,
        )

        # Get the query parameter for "is_single_pass_extract"
        is_single_pass_extract_param = self.request.GET.get(
            PromptStudioOutputManagerKeys.IS_SINGLE_PASS_EXTRACT, "false"
        )

        # Convert the string representation to a boolean value
        is_single_pass_extract = CommonUtils.str_to_bool(is_single_pass_extract_param)

        filter_args[PromptStudioOutputManagerKeys.IS_SINGLE_PASS_EXTRACT] = (
            is_single_pass_extract
        )

        if filter_args:
            queryset = PromptStudioOutputManager.objects.filter(**filter_args)
        else:
            queryset = PromptStudioOutputManager.objects.all()

        return queryset

    def get_output_for_tool_default(self, request: HttpRequest) -> Response:
        # Get the tool_id from request parameters
        # TODO: Setup Serializer here
        tool_id = request.GET.get("tool_id")
        document_manager_id = request.GET.get("document_manager")
        tool_validation_message = PromptOutputManagerErrorMessage.TOOL_VALIDATION
        tool_not_found = PromptOutputManagerErrorMessage.TOOL_NOT_FOUND
        if not tool_id:
            raise APIException(detail=tool_validation_message, code=400)

        try:
            # Fetch ToolStudioPrompt records based on tool_id
            tool_studio_prompts = ToolStudioPrompt.objects.filter(
                tool_id=tool_id
            ).order_by("sequence_number")
        except ObjectDoesNotExist:
            raise APIException(detail=tool_not_found, code=400)

        # Invoke helper method to frame and fetch default response.
        result: dict[str, Any] = OutputManagerHelper.fetch_default_output_response(
            tool_studio_prompts=tool_studio_prompts,
            document_manager_id=document_manager_id,
            use_default_profile=True,
        )

        return Response(result, status=status.HTTP_200_OK)

    def get_confidence_scores_for_file_execution(self, request: HttpRequest, file_execution_id: str) -> Response:
        """Get confidence scores for a file execution.
        
        Args:
            request: HTTP request
            file_execution_id: File execution ID to get confidence scores for
            
        Returns:
            Response with confidence scores list
        """
        try:
            # Query PromptStudioOutputManager for confidence scores related to this file execution
            # The file_execution_id should be stored in document_manager field or related metadata
            outputs = PromptStudioOutputManager.objects.filter(
                document_manager__document_id=file_execution_id
            ).exclude(
                confidence_data__isnull=True
            )
            
            confidence_scores = []
            for output in outputs:
                if output.confidence_data and "overall_confidence" in output.confidence_data:
                    confidence_scores.append(output.confidence_data["overall_confidence"])
            
            return Response({
                "confidence_scores": confidence_scores,
                "count": len(confidence_scores)
            }, status=status.HTTP_200_OK)
            
        except Exception as e:
            logger.error(f"Error retrieving confidence scores for file_execution_id {file_execution_id}: {e}")
            return Response({
                "confidence_scores": [],
                "count": 0,
                "error": str(e)
            }, status=status.HTTP_200_OK)
