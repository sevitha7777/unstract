"""Utilities to eagerly load SDK1 adapters so HTTP requests are never blocked."""

from __future__ import annotations

import logging
import os
import threading
import time
from typing import Literal

logger = logging.getLogger(__name__)

_PRELOAD_LOCK = threading.Lock()
_PRELOAD_STARTED = False
_PRELOAD_COMPLETED = False

PreloadMode = Literal["sync", "async"]


def _get_mode(mode: str | None) -> PreloadMode:
    """Return the effective preload mode, defaulting to sync."""
    effective_mode = (mode or os.environ.get("SDK1_PRELOAD_MODE", "sync")).lower()
    if effective_mode not in {"sync", "async"}:
        logger.warning(
            "Unknown SDK1 preload mode '%s'. Falling back to synchronous preload.",
            effective_mode,
        )
        return "sync"
    return effective_mode  # type: ignore[return-value]


def _load_adapters() -> None:
    """Warm the adapter registry."""
    from unstract.sdk1.adapters.adapterkit import Adapterkit

    start = time.perf_counter()
    Adapterkit()
    elapsed = time.perf_counter() - start
    logger.info("SDK1 adapters preloaded in %.2fs", elapsed)


def preload_adapters(mode: str | None = None) -> None:
    """Preload SDK1 adapters either synchronously or asynchronously.

    Args:
        mode: Optional override for preload strategy. Accepts ``sync`` or ``async``.
              Defaults to the ``SDK1_PRELOAD_MODE`` environment variable (``sync``).
    """

    global _PRELOAD_STARTED, _PRELOAD_COMPLETED

    with _PRELOAD_LOCK:
        if _PRELOAD_STARTED:
            return
        _PRELOAD_STARTED = True

    def runner() -> None:
        global _PRELOAD_COMPLETED
        try:
            _load_adapters()
        except Exception:
            logger.exception("SDK1 adapter preload failed")
        finally:
            with _PRELOAD_LOCK:
                _PRELOAD_COMPLETED = True

    effective_mode = _get_mode(mode)

    if effective_mode == "async":
        thread = threading.Thread(
            target=runner,
            name="sdk1-adapter-preload",
            daemon=True,
        )
        thread.start()
    else:
        runner()


def preload_completed() -> bool:
    """Return True once adapters have been preloaded."""
    with _PRELOAD_LOCK:
        return _PRELOAD_COMPLETED
