#! /bin/bash

. "$SYSTEM_DIR/scripts/check_envs"
check_envs ENV PRUNE_LABEL

cat << EOS > kustomization.yml
bases:
  - overlays/${ENV}
commonLabels:
  pruneLabel: ${PRUNE_LABEL}
EOS