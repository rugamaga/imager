#! /bin/sh

. "$SYSTEM_DIR/scripts/check_envs"
check_envs ENV IMAGE_NAME IMAGE_TAG PRUNE_LABEL DATABASE_URL

cat << EOS > imager-server-secret.env
DATABASE_URL=${DATABASE_URL}
EOS

cat << EOS > kustomization.yml
bases:
  - overlays/${ENV}
configMapGenerator:
  - name: imager-server-config
    literals:
      - RACK_ENV=production
secretGenerator:
  - name: imager-server-secret
    env: imager-server-secret.env
images:
  - name: imager-server
    newName: ${IMAGE_NAME}
    newTag: ${IMAGE_TAG}
commonLabels:
  pruneLabel: ${PRUNE_LABEL}
EOS