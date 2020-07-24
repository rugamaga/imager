#! /bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)/"; pwd)

# ----------------- check envs
. "${SCRIPT_DIR}/check_envs"
check_envs SYSTEM COMPONENT ACTION REGISTRY TAG
set_envs

# ----------------- generate manifests
(
  echo "chage directory to ${ACTION_DIR}"
  cd ${ACTION_DIR}
  echo "genereate settings..."
  ./generate.sh
)

# ----------------- plan
(
  echo "chage directory to ${COMPONENT_DIR}"
  cd "${COMPONENT_DIR}"
  # check manifest by server-dry-run
  kubectl apply -k ${ACTION_DIR} --server-dry-run --prune -l pruneLabel=${PRUNE_LABEL}
  if [ $? -gt 0 ]; then
    echo "dryrun failure" 1>&2
    exit 1
  fi
  # diff from server manifest to local manifest 
  kubectl diff -k ${ACTION_DIR}
  exit 0
)