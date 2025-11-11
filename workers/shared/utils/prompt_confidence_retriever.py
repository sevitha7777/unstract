"""Prompt Confidence Retriever

This module retrieves confidence scores from individual prompts stored in the database
and calculates aggregate confidence for API responses.
"""

import logging
from typing import Any, Dict, List, Optional

logger = logging.getLogger(__name__)


class PromptConfidenceRetriever:
    """Retrieves and aggregates confidence scores from prompt database records."""

    @staticmethod
    def get_aggregate_confidence_for_workflow(
        workflow_id: str, 
        document_id: str,
        organization_id: str
    ) -> Optional[Dict[str, Any]]:
        """Get aggregate confidence score from all prompts in a workflow.
        
        Args:
            workflow_id: The workflow ID
            document_id: The document ID  
            organization_id: The organization ID
            
        Returns:
            Dict with confidence data or None if no confidence scores found
        """
        try:
            # Import Django models here to avoid import issues
            from prompt_studio.prompt_studio_output_manager_v2.models import PromptStudioOutputManager
            from prompt_studio.prompt_studio_document_manager_v2.models import DocumentManager
            from prompt_studio.prompt_studio_v2.models import ToolStudioPrompt
            from prompt_studio.prompt_profile_manager_v2.models import ProfileManager
            
            # Get document manager
            try:
                document_manager = DocumentManager.objects.get(pk=document_id)
            except DocumentManager.DoesNotExist:
                logger.warning(f"DocumentManager {document_id} not found")
                return None
            
            # Get tool from workflow (assuming workflow has associated tool)
            tool = document_manager.tool_id
            if not tool:
                logger.warning(f"No tool found for document {document_id}")
                return None
                
            # Get default profile for the tool
            try:
                default_profile = ProfileManager.get_default_llm_profile(tool=tool)
            except Exception:
                logger.warning(f"No default profile found for tool {tool.id}")
                return None
            
            # Get all prompts for the tool
            prompts = ToolStudioPrompt.objects.filter(tool_id=tool)
            if not prompts.exists():
                logger.warning(f"No prompts found for tool {tool.id}")
                return None
            
            confidence_scores = []
            
            # Query confidence scores from each prompt
            for prompt in prompts:
                if prompt.prompt_type == "NOTES":  # Skip notes prompts
                    continue
                    
                try:
                    output_obj = PromptStudioOutputManager.objects.filter(
                        prompt_id=prompt,
                        profile_manager=default_profile,
                        is_single_pass_extract=False,
                        document_manager=document_manager,
                    ).first()
                    
                    if output_obj and output_obj.confidence_data:
                        confidence = PromptConfidenceRetriever._extract_confidence_from_data(
                            output_obj.confidence_data
                        )
                        if confidence is not None:
                            confidence_scores.append(confidence)
                            logger.info(f"Found confidence {confidence} for prompt {prompt.prompt_key}")
                            
                except Exception as e:
                    logger.warning(f"Error getting confidence for prompt {prompt.prompt_key}: {e}")
                    continue
            
            # Calculate aggregate confidence
            if confidence_scores:
                aggregate_confidence = sum(confidence_scores) / len(confidence_scores)
                logger.info(f"Calculated aggregate confidence: {aggregate_confidence} from {len(confidence_scores)} prompts")
                
                return {
                    '_confidence': round(aggregate_confidence, 3),
                    '_confidence_method': 'average',
                    '_confidence_count': len(confidence_scores)
                }
            else:
                logger.info("No confidence scores found for any prompts")
                return None
                
        except Exception as e:
            logger.error(f"Error retrieving prompt confidence scores: {e}")
            return None
    
    @staticmethod
    def _extract_confidence_from_data(confidence_data: Dict[str, Any]) -> Optional[float]:
        """Extract confidence score from confidence_data field.
        
        Args:
            confidence_data: The confidence_data field from PromptStudioOutputManager
            
        Returns:
            Float confidence score or None
        """
        if not isinstance(confidence_data, dict):
            return None
            
        # Try different possible keys for confidence score
        for key in ['confidence_score', 'confidence', 'score']:
            if key in confidence_data:
                try:
                    return float(confidence_data[key])
                except (ValueError, TypeError):
                    continue
                    
        return None