#!/bin/bash
set -e

BIN="$1"
shift

if [[ -n "${MONAD_CPUSET:-}" ]]; then
  exec taskset -c "$MONAD_CPUSET" "$BIN" "$@"
fi

if [[ "${MONAD_NATIVE:-false}" == "true" ]]; then
  exec "$BIN" "$@"
fi

exec cpulimit --foreground -l "${MONAD_CPU_LIMIT:-50}" -- "$BIN" "$@"
