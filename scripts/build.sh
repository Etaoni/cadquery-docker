#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-cadquery:2.7.0}"
INSTALL_CQ_CLI="${INSTALL_CQ_CLI:-1}"

docker build --pull \
  --build-arg INSTALL_CQ_CLI="${INSTALL_CQ_CLI}" \
  -t "${TAG}" \
  .
