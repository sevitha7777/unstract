import json
import logging
from typing import Any

from django.core.exceptions import ObjectDoesNotExist

from prompt_studio.prompt_profile_manager_v2.models import ProfileManager
from prompt_studio.prompt_studio_core_v2.exceptions import (
    AnswerFetchError,
    DefaultProfileError,
)
from prompt_studio.prompt_studio_core_v2.models import CustomTool
from prompt_studio.prompt_studio_document_manager_v2.models import DocumentManager
from prompt_studio.prompt_studio_output_manager_v2.constants import (
    PromptStudioOutputManagerKeys as PSOMKeys,
)
from prompt_studio.prompt_studio_output_manager_v2.models import (
    PromptStudioOutputManager,
)
from prompt_studio.prompt_studio_output_manager_v2.serializers import (
    PromptStudioOutputSerializer,
)
from prompt_studio.prompt_studio_v2.models import ToolStudioPrompt

logger = logging.getLogger(__name__)


class OutputManagerHelper:
    @staticmethod
    def handle_prompt_output_update(
        run_id: str,
        prompts: list[ToolStudioPrompt],
        outputs: Any,
        document_id: str,
        is_single_pass_extract: bool,
        metadata: dict[str, Any],
        profile_manager_id: str | None = None,
    ) -> list[dict[str, Any]]:
        """Handles updating prompt outputs in the database and returns
        serialized data.

        Args:
            run_id (str): ID of the run.
            prompts (list[ToolStudioPrompt]): List of prompts to update.
            outputs (Any): Outputs corresponding to the prompts.
            document_id (str): ID of the document.
            profile_manager_id (Optional[str]): UUID of the profile manager.
            is_single_pass_extract (bool): Flag indicating if single pass
            extract is active.
            metadata (dict[str, Any]): Metadata for the update.

        Returns:
            list[dict[str, Any]]: List of serialized prompt output data.
        """
        # Basic validation
        if not prompts or not document_id or outputs is None:
            logger.error(f"Invalid input: prompts={len(prompts) if prompts else 0}, document_id={document_id}, outputs_provided={outputs is not None}")
            return []

        def update_or_create_prompt_output(
            prompt: ToolStudioPrompt,
            profile_manager: ProfileManager,
            output: str,
            eval_metrics: list[Any],
            tool: CustomTool,
            context: str,
            challenge_data: dict[str, Any] | None,
            highlight_data: dict[str, Any] | None,
            confidence_data: dict[str, Any] | None,
        ) -> PromptStudioOutputManager:
            """Handles creating or updating a single prompt output and returns
            the instance.
            """
            try:
                prompt_output, success = PromptStudioOutputManager.objects.get_or_create(
                    document_manager=document_manager,
                    tool_id=tool,
                    profile_manager=profile_manager,
                    prompt_id=prompt,
                    is_single_pass_extract=is_single_pass_extract,
                    defaults={
                        "output": output or "",
                        "eval_metrics": eval_metrics or [],
                        "context": context,
                        "challenge_data": challenge_data,
                        "highlight_data": highlight_data,
                        "confidence_data": confidence_data,
                    },
                )

                if not success:
                    # Update existing record
                    args: dict[str, Any] = {
                        "run_id": run_id,
                        "output": output or "",
                        "eval_metrics": eval_metrics or [],
                        "context": context,
                        "challenge_data": challenge_data,
                        "highlight_data": highlight_data,
                        "confidence_data": confidence_data,
                    }
                    PromptStudioOutputManager.objects.filter(
                        document_manager=document_manager,
                        tool_id=tool,
                        profile_manager=profile_manager,
                        prompt_id=prompt,
                        is_single_pass_extract=is_single_pass_extract,
                    ).update(**args)
                    prompt_output.refresh_from_db()

                return prompt_output

            except Exception as e:
                import traceback
                logger.error(f"Error updating prompt output for {prompt.prompt_key}: {e}")
                logger.error(f"Full traceback: {traceback.format_exc()}")
                raise AnswerFetchError(f"Error updating prompt output {e}") from e

        # List to store serialized results
        serialized_data: list[dict[str, Any]] = []
        context = metadata.get("context")
        challenge_data = metadata.get("challenge_data")
        highlight_data = metadata.get("highlight_data")
        confidence_data = metadata.get("confidence_data")

        if not prompts:
            return serialized_data

        tool = prompts[0].tool_id
        default_profile = OutputManagerHelper.get_default_profile(
            profile_manager_id, tool
        )
        try:
            document_manager = DocumentManager.objects.get(pk=document_id)
        except DocumentManager.DoesNotExist:
            logger.error(f"DocumentManager with ID {document_id} does not exist")
            raise AnswerFetchError(f"DocumentManager with ID {document_id} does not exist")

        for prompt in prompts:
            if prompt.prompt_type == PSOMKeys.NOTES:
                continue

            # Get prompt-specific data without modifying the original variables
            prompt_context = context
            prompt_highlight_data = highlight_data
            prompt_confidence_data = confidence_data
            prompt_challenge_data = challenge_data
            
            if not is_single_pass_extract:
                if context:
                    prompt_context = context.get(prompt.prompt_key)
                if highlight_data:
                    prompt_highlight_data = highlight_data.get(prompt.prompt_key)
                if confidence_data:
                    prompt_confidence_data = confidence_data.get(prompt.prompt_key)
                if challenge_data:
                    prompt_challenge_data = challenge_data.get(prompt.prompt_key)

            if prompt_challenge_data:
                prompt_challenge_data["file_name"] = metadata.get("file_name")

            # TODO: use enums here
            output = outputs.get(prompt.prompt_key)
            if prompt.enforce_type in {"json", "table", "record", "line-item"}:
                output = json.dumps(output)
            eval_metrics = outputs.get(f"{prompt.prompt_key}__evaluation", [])
            profile_manager = default_profile

            # Safely serialize context
            try:
                context_str = json.dumps(prompt_context) if prompt_context else None
            except (TypeError, ValueError):
                context_str = None

            # Update or create the prompt output
            prompt_output = update_or_create_prompt_output(
                prompt=prompt,
                profile_manager=profile_manager,
                output=output,
                eval_metrics=eval_metrics,
                tool=tool,
                context=context_str,
                challenge_data=prompt_challenge_data,
                highlight_data=prompt_highlight_data,
                confidence_data=prompt_confidence_data,
            )

            # Serialize the instance
            serializer = PromptStudioOutputSerializer(prompt_output)
            serialized_data.append(serializer.data)

        try:
            return serialized_data
        except Exception as e:
            import traceback
            logger.error(f"Unexpected error in handle_prompt_output_update: {e}")
            logger.error(f"Full traceback: {traceback.format_exc()}")
            raise

    @staticmethod
    def get_default_profile(
        profile_manager_id: str | None, tool: CustomTool
    ) -> ProfileManager:
        if profile_manager_id:
            return OutputManagerHelper.fetch_profile_manager(profile_manager_id)
        else:
            return OutputManagerHelper.fetch_default_llm_profile(tool)

    @staticmethod
    def fetch_profile_manager(profile_manager_id: str) -> ProfileManager:
        try:
            return ProfileManager.objects.get(profile_id=profile_manager_id)
        except ProfileManager.DoesNotExist:
            raise DefaultProfileError(
                f"ProfileManager with ID {profile_manager_id} does not exist."
            )

    @staticmethod
    def fetch_default_llm_profile(tool: CustomTool) -> ProfileManager:
        try:
            return ProfileManager.get_default_llm_profile(tool=tool)
        except DefaultProfileError:
            raise DefaultProfileError("Default ProfileManager does not exist.")

    @staticmethod
    def fetch_default_output_response(
        tool_studio_prompts: list[ToolStudioPrompt],
        document_manager_id: str,
        use_default_profile: bool = False,
    ) -> dict[str, Any]:
        """Method to frame JSON responses for combined output for default for
        default profile manager of the project.

        Args:
            tool_studio_prompts (list[ToolStudioPrompt])
            document_manager_id (str)
            use_default_profile (bool)

        Returns:
            dict[str, Any]: Formatted JSON response for combined output.
        """
        result: dict[str, Any] = {}
        confidence_scores: list[float] = []
        
        if not tool_studio_prompts:
            return result
            
        # Get the default profile for the tool
        try:
            default_profile = ProfileManager.get_default_llm_profile(
                tool_studio_prompts[0].tool_id
            )
        except DefaultProfileError:
            # Return empty results for all prompts if no default profile
            for tool_prompt in tool_studio_prompts:
                if tool_prompt.prompt_type != PSOMKeys.NOTES:
                    result[tool_prompt.prompt_key] = ""
            return result
        
        # Process each prompt
        for tool_prompt in tool_studio_prompts:
            if tool_prompt.prompt_type == PSOMKeys.NOTES:
                continue
                
            # Always use the default profile for default output
            profile_manager_id = default_profile.profile_id

            try:
                queryset = PromptStudioOutputManager.objects.filter(
                    prompt_id=tool_prompt,
                    profile_manager=default_profile,
                    is_single_pass_extract=False,
                    document_manager_id=document_manager_id,
                )

                if queryset.exists():
                    output_obj = queryset.first()
                    result[tool_prompt.prompt_key] = output_obj.output or ""
                    
                    # Extract confidence score if available
                    logger.info(f"Checking confidence for prompt {tool_prompt.prompt_key}: {output_obj.confidence_data}")
                    if output_obj.confidence_data and isinstance(output_obj.confidence_data, dict):
                        confidence = output_obj.confidence_data.get('confidence_score')
                        logger.info(f"Found confidence score for {tool_prompt.prompt_key}: {confidence}")
                        if confidence is not None:
                            try:
                                confidence_scores.append(float(confidence))
                                logger.info(f"Added confidence score: {confidence}")
                            except (ValueError, TypeError):
                                logger.warning(f"Invalid confidence score format: {confidence}")
                                pass
                else:
                    result[tool_prompt.prompt_key] = ""
                    
            except Exception:
                result[tool_prompt.prompt_key] = ""
        
        # Calculate combined confidence score
        logger.info(f"Collected confidence scores: {confidence_scores}")
        if confidence_scores:
            combined_confidence = sum(confidence_scores) / len(confidence_scores)
            result['_combined_confidence'] = round(combined_confidence, 2)
            logger.info(f"Combined confidence calculated: {result['_combined_confidence']}")
        else:
            logger.info("No confidence scores found for combined output")
                
        return result
