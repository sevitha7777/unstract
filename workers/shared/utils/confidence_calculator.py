"""Confidence Calculator for aggregating individual prompt confidence scores."""

import logging
from typing import Any

logger = logging.getLogger(__name__)


class ConfidenceCalculator:
    """Calculator for aggregating confidence scores from multiple prompts."""

    def calculate_aggregate_confidence(
        self, confidence_scores: list[float], method: str = "average"
    ) -> float | None:
        """Calculate aggregate confidence from individual prompt scores.

        Args:
            confidence_scores: List of confidence scores from individual prompts
            method: Aggregation method ("average", "minimum", "maximum")

        Returns:
            Aggregated confidence score or None if no valid scores
        """
        if not confidence_scores:
            return None

        # Filter out invalid scores
        valid_scores = [score for score in confidence_scores if isinstance(score, (int, float)) and 0 <= score <= 1]
        
        if not valid_scores:
            return None

        if method == "average":
            return sum(valid_scores) / len(valid_scores)
        elif method == "minimum":
            return min(valid_scores)
        elif method == "maximum":
            return max(valid_scores)
        else:
            # Default to average
            return sum(valid_scores) / len(valid_scores)

    def add_confidence_to_result(
        self, result: dict[str, Any], confidence_scores: list[float]
    ) -> dict[str, Any]:
        """Add aggregate confidence to result dictionary.

        Args:
            result: Result dictionary to add confidence to
            confidence_scores: List of confidence scores

        Returns:
            Result dictionary with confidence added
        """
        if not result or not confidence_scores:
            return result

        aggregate_confidence = self.calculate_aggregate_confidence(confidence_scores)
        if aggregate_confidence is not None:
            result["_confidence"] = round(aggregate_confidence, 3)
            result["_confidence_method"] = "average"
            result["_confidence_count"] = len(confidence_scores)
            logger.info(f"Added aggregate confidence {aggregate_confidence:.3f} from {len(confidence_scores)} prompts")

        return result