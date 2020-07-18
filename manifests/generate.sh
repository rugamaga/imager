#! /bin/sh

BASEDIR=$(dirname "$0")

${BASEDIR}/imager-database-secret.sh > ${BASEDIR}/imager-database-secret.env
${BASEDIR}/kustomization.sh > ${BASEDIR}/kustomization.yml
