#! /bin/bash

cat << EOS > imager-server-secret.env
DATABASE_URL=${DATABASE_URL}
EOS

cat << EOS > imager-database-secret.env
POSTGRES_PASSWORD=${IMAGER_DATABASE_PASSWORD}
EOS

cat << EOS > kustomization.yml
bases:
  - overlays/${KUSTOMIZATION_ENV}
images:
  - name: imager-server
    newName: ${CONTAINER_REGISTRY_URL}/${CONTAINER_IMAGE_NAME}
    newTag: ${CIRCLE_SHA1}
configMapGenerator:
  - name: imager-database-config
    literals:
      - POSTGRES_USER=rugamaga
      - POSTGRES_INITDB_ARGS="--encoding=UTF=8"
      - PGDATA=/var/lib/postgresql/data/pgdata
  - name: imager-server-config
    literals:
      - RACK_ENV=production
secretGenerator:
  - name: imager-database-secret
    env: imager-database-secret.env
  - name: imager-server-secret
    env: imager-server-secret.env
commonLabels:
  pruneLabel: ${PRUNE_LABEL}
EOS