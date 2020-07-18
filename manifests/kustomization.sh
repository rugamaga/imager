#! /bin/bash

cat << EOS
bases:
  - overlays/${KUSTOMIZATION_ENV}
configMapGenerator:
  - name: imager-database-config
    literals:
      - POSTGRES_USER=rugamaga
      - POSTGRES_INITDB_ARGS="--encoding=UTF=8"
      - PGDATA=/var/lib/postgresql/data/pgdata
secretGenerator:
  - name: imager-database-secret
    env: imager-database-secret.env
commonLabels:
  pruneLabel: ${PRUNE_LABEL}
EOS
