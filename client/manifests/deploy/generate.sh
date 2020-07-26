#! /bin/sh

. "$SYSTEM_DIR/scripts/check_envs"
check_envs ENV IMAGE_NAME IMAGE_TAG PRUNE_LABEL

cat << EOS > kustomization.yml
bases:
  - overlays/${ENV}
images:
  - name: imager-client
    newName: ${IMAGE_NAME}
    newTag: ${IMAGE_TAG}
commonLabels:
  pruneLabel: ${PRUNE_LABEL}
EOS