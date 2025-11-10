"""Confidence Score Calculator for Workflow Outputs

This module provides utilities for calculating aggregate confidence scores
from individual field confidence scores in workflow execution results.
"""

import logging
from typing import Any, Dict, List, Optional

logger = logging.getLogger(__name__)


class ConfidenceCalculator:
    """Calculates aggregate confidence scores from individual field confidence scores."""

    @staticmethod
    def extract_confidence_scores(result: Dict[str, Any]) -> List[float]:
        """Extract individual confidence scores from result data.
        
        Args:
            result: The tool execution result containing field data
            
        Returns:
            List of confidence scores found in the result
        """
        confidence_scores = []
        
        if not isinstance(result, dict):
            return confidence_scores
            
        # Look for confidence scores in various formats
        for key, value in result.items():
            # Skip metadata and system fields
            if key.startswith('_') or key in ['metadata', 'whisper-hash', 'extracted_text']:
                continue
                
            # Check if this field has confidence data
            confidence = ConfidenceCalculator._extract_field_confidence(key, value, result)
            if confidence is not None:
                confidence_scores.append(confidence)
                
        return confidence_scores

    @staticmethod
    def _extract_field_confidence(field_name: str, field_value: Any, full_result: Dict[str, Any]) -> Optional[float]:
        """Extract confidence score for a specific field.
        
        Args:
            field_name: Name of the field
            field_value: Value of the field
            full_result: Complete result dictionary
            
        Returns:
            Confidence score if found, None otherwise
        """
        # Method 1: Look for field_name_confidence pattern
        confidence_key = f"{field_name}_confidence"
        if confidence_key in full_result:
            try:
                return float(full_result[confidence_key])
            except (ValueError, TypeError):
                pass
                
        # Method 2: Look for nested confidence in field value
        if isinstance(field_value, dict):
            if 'confidence' in field_value:
                try:
                    return float(field_value['confidence'])
                except (ValueError, TypeError):
                    pass
            if 'confidence_score' in field_value:
                try:
                    return float(field_value['confidence_score'])
                except (ValueError, TypeError):
                    pass
                    
        # Method 3: Look in metadata for field-specific confidence
        metadata = full_result.get('metadata', {})
        if isinstance(metadata, dict):
            confidence_data = metadata.get('confidence_data', {})
            if isinstance(confidence_data, dict):
                field_confidence = confidence_data.get(field_name, {})
                if isinstance(field_confidence, dict):
                    if 'confidence_score' in field_confidence:
                        try:
                            return float(field_confidence['confidence_score'])
                        except (ValueError, TypeError):
                            pass
                elif isinstance(field_confidence, (int, float)):
                    try:
                        return float(field_confidence)
                    except (ValueError, TypeError):
                        pass
                        
        return None

    @staticmethod
    def calculate_aggregate_confidence(confidence_scores: List[float], method: str = "average") -> Optional[float]:
        """Calculate aggregate confidence score from individual scores.
        
        Args:
            confidence_scores: List of individual confidence scores
            method: Aggregation method ("average", "weighted_average", "minimum", "maximum")
            
        Returns:
            Aggregate confidence score, None if no scores available
        """
        if not confidence_scores:
            return None
            
        if method == "average":
            return sum(confidence_scores) / len(confidence_scores)
        elif method == "minimum":
            return min(confidence_scores)
        elif method == "maximum":
            return max(confidence_scores)
        elif method == "weighted_average":
            # For now, use simple average. Could be enhanced with field weights
            return sum(confidence_scores) / len(confidence_scores)
        else:
            logger.warning(f"Unknown aggregation method: {method}, using average")
            return sum(confidence_scores) / len(confidence_scores)

    @staticmethod
    def add_confidence_to_result(result: Dict[str, Any], method: str = "average") -> Dict[str, Any]:
        """Add aggregate confidence score to result data.
        
        Args:
            result: The tool execution result
            method: Aggregation method for confidence calculation
            
        Returns:
            Result with added confidence score
        """
        if not isinstance(result, dict):
            return result
            
        # Extract individual confidence scores
        confidence_scores = ConfidenceCalculator.extract_confidence_scores(result)
        
        if confidence_scores:
            # Calculate aggregate confidence
            aggregate_confidence = ConfidenceCalculator.calculate_aggregate_confidence(
                confidence_scores, method
            )
            
            if aggregate_confidence is not None:
                # Add to result
                result_copy = result.copy()
                result_copy['_confidence'] = round(aggregate_confidence, 3)
                result_copy['_confidence_method'] = method
                result_copy['_confidence_count'] = len(confidence_scores)
                
                logger.info(
                    f"Added aggregate confidence: {aggregate_confidence:.3f} "
                    f"(method: {method}, fields: {len(confidence_scores)})"
                )
                
                return result_copy
        else:
            logger.debug("No confidence scores found in result data")
            
        return result