#! /bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)/"; pwd)

# ----------------- check envs
. "${SCRIPT_DIR}/check_envs"
check_envs SYSTEM COMPONENT REGISTRY TAG
set_envs

(
    # Move current directory to component dir
    cd "${COMPONENT_DIR}"
    # Build Dockerfile
    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
    # Push docker image to container registry
    docker push ${IMAGE_NAME}:${IMAGE_TAG}
)