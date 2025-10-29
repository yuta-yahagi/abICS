#!/bin/sh
# Wrapper that keeps backward compatibility with the previous GNU parallel script
# by delegating to the new aiida_run implementation.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$SCRIPT_DIR/aiida_run" "$@"
