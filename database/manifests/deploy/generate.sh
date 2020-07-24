#! /bin/bash

. "$SYSTEM_DIR/scripts/check_envs"
check_envs ENV IMAGE_NAME IMAGE_TAG PRUNE_LABEL IMAGER_DATABASE_PASSWORD

cat << EOS > imager-database-secret.env
POSTGRES_PASSWORD=${IMAGER_DATABASE_PASSWORD}
EOS

cat << EOS > kustomization.yml
bases:
  - overlays/${ENV}
configMapGenerator:
  - name: imager-database-config
    literals:
      - POSTGRES_USER=rugamaga
      - POSTGRES_INITDB_ARGS="--encoding=UTF=8"
      - PGDATA=/var/lib/postgresql/data/pgdata
secretGenerator:
  - name: imager-database-secret
    env: imager-database-secret.env
images:
  - name: imager-server
    newName: ${IMAGE_NAME}
    newTag: ${IMAGE_TAG}
commonLabels:
  pruneLabel: ${PRUNE_LABEL}
EOS