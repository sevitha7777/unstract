"""Feature flag utils file."""

import logging
import os
import threading

from .client.evaluation import EvaluationClient

logger = logging.getLogger(__name__)

_SDK1_PRELOAD_LOCK = threading.Lock()
_SDK1_PRELOAD_TRIGGERED = False


def _maybe_preload_sdk1_adapters() -> None:
    """Warm SDK1 adapters once the flag is enabled."""
    global _SDK1_PRELOAD_TRIGGERED

    with _SDK1_PRELOAD_LOCK:
        if _SDK1_PRELOAD_TRIGGERED:
            return
        _SDK1_PRELOAD_TRIGGERED = True

    try:
        from unstract.sdk1.preload import preload_adapters
    except ImportError:
        logger.debug("SDK1 package not available; skipping adapter preload.")
        return

    try:
        preload_adapters(mode=os.environ.get("SDK1_PRELOAD_MODE"))
    except Exception as exc:  # pragma: no cover - defensive logging
        logger.warning("SDK1 adapter preload failed: %s", exc)


def check_feature_flag_status(
    flag_key: str,
    namespace_key: str = "default",
    entity_id: str = "unstract",
    context: dict[str, str] | None = None,
) -> bool:
    """Check the status of a feature flag for a given entity.

    Args:
        namespace_key (str): The namespace key of the feature flag.
        flag_key (str): The flag key of the feature flag.
        entity_id (str): The ID of the entity for which the feature flag status
        is checked.
        context (dict, optional): Additional context data for evaluating the
        feature flag. Defaults to None.

    Returns:
        bool:
        True if the feature flag is enabled for the entity, False otherwise.
    """
    flag_enabled = False
    try:
        FLIPT_SERVICE_AVAILABLE = (
            os.environ.get("FLIPT_SERVICE_AVAILABLE", "false").lower() == "true"
        )
        if not FLIPT_SERVICE_AVAILABLE:
            # Check environment variables for feature flags when Flipt is not available
            env_var_name = f"{flag_key.upper()}_ENABLED"
            flag_enabled = os.environ.get(env_var_name, "false").lower() == "true"
        else:
            evaluation_client = EvaluationClient()
            response = evaluation_client.boolean_evaluate_feature_flag(
                namespace_key=namespace_key,
                flag_key=flag_key,
                entity_id=entity_id,
                context=context,
            )
            flag_enabled = bool(response)  # Wrap the response in a boolean check
    except Exception:
        return False

    if flag_enabled and flag_key.lower() == "sdk1":
        _maybe_preload_sdk1_adapters()

    return flag_enabled
