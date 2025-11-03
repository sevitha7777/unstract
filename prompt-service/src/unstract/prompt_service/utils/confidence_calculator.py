"""Confidence calculation utilities for prompt outputs."""

import json
import logging
import re
from typing import Any, Dict, Optional

logger = logging.getLogger(__name__)


class ConfidenceCalculator:
    """Calculate confidence scores for LLM outputs based on various metrics."""
    
    @staticmethod
    def calculate_confidence(
        output: str,
        prompt_type: str = "text",
        context: Optional[str] = None,
        token_usage: Optional[Dict[str, Any]] = None,
        **kwargs
    ) -> Dict[str, Any]:
        """
        Calculate confidence score for LLM output.
        
        Args:
            output: The LLM response text
            prompt_type: Type of prompt (text, json, table, etc.)
            context: Source context used for extraction
            token_usage: Token usage statistics
            **kwargs: Additional parameters
            
        Returns:
            Dict containing confidence score and metrics
        """
        try:
            confidence_data = {
                "overall_confidence": 0.0,
                "metrics": {},
                "factors": []
            }
            
            if not output or output.strip() == "":
                return confidence_data
                
            # Calculate different confidence factors
            factors = []
            
            # 1. Output completeness factor
            completeness_score = ConfidenceCalculator._calculate_completeness(output, prompt_type)
            factors.append(("completeness", completeness_score, 0.3))
            
            # 2. Format validity factor
            format_score = ConfidenceCalculator._calculate_format_validity(output, prompt_type)
            factors.append(("format_validity", format_score, 0.25))
            
            # 3. Content consistency factor
            consistency_score = ConfidenceCalculator._calculate_consistency(output, context)
            factors.append(("consistency", consistency_score, 0.25))
            
            # 4. Token efficiency factor
            efficiency_score = ConfidenceCalculator._calculate_token_efficiency(output, token_usage)
            factors.append(("token_efficiency", efficiency_score, 0.2))
            
            # Calculate weighted confidence score
            overall_confidence = sum(score * weight for _, score, weight in factors)
            
            confidence_data.update({
                "overall_confidence": round(overall_confidence, 3),
                "metrics": {
                    factor: {"score": round(score, 3), "weight": weight}
                    for factor, score, weight in factors
                },
                "factors": [f"{factor}: {round(score, 2)}" for factor, score, _ in factors]
            })
            
            return confidence_data
            
        except Exception as e:
            logger.error(f"Error calculating confidence: {e}")
            return {
                "overall_confidence": 0.0,
                "metrics": {},
                "factors": ["calculation_error"],
                "error": str(e)
            }
    
    @staticmethod
    def _calculate_completeness(output: str, prompt_type: str) -> float:
        """Calculate completeness score based on output length and content."""
        if not output:
            return 0.0
            
        # Basic length check
        length_score = min(len(output.strip()) / 50, 1.0)  # Normalize to 50 chars
        
        # Check for incomplete indicators
        incomplete_indicators = ["...", "incomplete", "partial", "truncated"]
        has_incomplete = any(indicator in output.lower() for indicator in incomplete_indicators)
        
        if has_incomplete:
            length_score *= 0.5
            
        # Type-specific completeness checks
        if prompt_type == "json":
            try:
                json.loads(output)
                return min(length_score + 0.3, 1.0)  # Bonus for valid JSON
            except:
                return max(length_score - 0.3, 0.0)  # Penalty for invalid JSON
                
        return length_score
    
    @staticmethod
    def _calculate_format_validity(output: str, prompt_type: str) -> float:
        """Calculate format validity score based on expected output format."""
        if not output:
            return 0.0
            
        if prompt_type == "json":
            try:
                parsed = json.loads(output)
                # Check if it's a meaningful JSON structure
                if isinstance(parsed, dict) and len(parsed) > 0:
                    return 1.0
                elif isinstance(parsed, list) and len(parsed) > 0:
                    return 0.9
                else:
                    return 0.5
            except:
                return 0.0
                
        elif prompt_type == "table":
            # Check for table-like structure
            lines = output.strip().split('\n')
            if len(lines) > 1:
                return 0.8
            return 0.4
            
        else:  # text
            # Check for coherent text structure
            sentences = re.split(r'[.!?]+', output)
            if len(sentences) > 1:
                return 0.9
            return 0.7
    
    @staticmethod
    def _calculate_consistency(output: str, context: Optional[str]) -> float:
        """Calculate consistency score between output and source context."""
        if not output or not context:
            return 0.5  # Neutral score when context unavailable
            
        # Simple keyword overlap check
        output_words = set(re.findall(r'\w+', output.lower()))
        context_words = set(re.findall(r'\w+', context.lower()))
        
        if not output_words:
            return 0.0
            
        overlap = len(output_words.intersection(context_words))
        overlap_ratio = overlap / len(output_words)
        
        return min(overlap_ratio * 2, 1.0)  # Scale up the ratio
    
    @staticmethod
    def _calculate_token_efficiency(output: str, token_usage: Optional[Dict[str, Any]]) -> float:
        """Calculate efficiency score based on token usage."""
        if not token_usage or not output:
            return 0.5  # Neutral score when data unavailable
            
        try:
            prompt_tokens = token_usage.get("prompt_tokens", 0)
            completion_tokens = token_usage.get("completion_tokens", 0)
            
            if completion_tokens == 0:
                return 0.0
                
            # Calculate efficiency as output quality per token
            output_length = len(output.strip())
            efficiency = output_length / completion_tokens
            
            # Normalize efficiency score (assuming 1-5 chars per token is good)
            normalized_efficiency = min(efficiency / 3.0, 1.0)
            
            return normalized_efficiency
            
        except Exception:
            return 0.5