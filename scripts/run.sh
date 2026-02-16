#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-cadquery:2.7.0}"
shift || true

# Host-side cache directory (respects XDG_CACHE_HOME if you use it)
HOST_CACHE_ROOT="${XDG_CACHE_HOME:-$HOME/.cache}"
HOST_CQ_CACHE="${HOST_CACHE_ROOT}/cadquery-docker"
mkdir -p "${HOST_CQ_CACHE}"

docker run --rm -it \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -e XDG_CACHE_HOME=/cache \
  -v "${HOST_CQ_CACHE}":/cache \
  -v "$PWD":/work \
  -w /work \
  "${IMAGE}" \
  "$@"
