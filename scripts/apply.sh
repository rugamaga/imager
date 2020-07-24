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
  kubectl apply -k ${ACTION_DIR} --prune -l pruneLabel=${PRUNE_LABEL}
)