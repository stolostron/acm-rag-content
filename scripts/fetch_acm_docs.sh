#!/bin/bash
set -eou pipefail

if [ -z "${1-}" ]; then
    echo "Error: ACM_VERSION argument is missing."
    echo "Usage: $0 <ACM_VERSION> <REPO_DIR> [OUTPUT_DIR]"
    exit 1
fi

if [ -z "${2-}" ]; then
    echo "Error: REPO_DIR argument is missing."
    echo "Usage: $0 <ACM_VERSION> <REPO_DIR> [OUTPUT_DIR]"
    exit 1
fi

ACM_VERSION=$1
REPO_DIR=$2
OUTPUT_DIR=${3:-"docs/acm/${ACM_VERSION}"}

# Ensure parent directory of REPO_DIR exists
mkdir -p "$(dirname "${REPO_DIR}")"

# Safety guardrail to prevent catastrophic deletion
if [[ "${OUTPUT_DIR}" != docs/* && "${OUTPUT_DIR}" != tmp/* && "${OUTPUT_DIR}" != */docs/* && "${OUTPUT_DIR}" != */tmp/* ]]; then
    echo "Error: OUTPUT_DIR (${OUTPUT_DIR}) seems unsafe to delete. It must be inside a docs or tmp directory."
    exit 1
fi

# Ensure output directory is clean
rm -rf "${OUTPUT_DIR}"

# Determine branch name
BRANCH_NAME="${ACM_VERSION}_prod"
if ! git ls-remote --exit-code --heads https://github.com/stolostron/rhacm-docs.git "${BRANCH_NAME}" >/dev/null 2>&1; then
    echo "Warning: '${BRANCH_NAME}' not found. Falling back to '${ACM_VERSION}_stage'."
    BRANCH_NAME="${ACM_VERSION}_stage"
fi

if [ -d "${REPO_DIR}/.git" ]; then
    echo "Updating existing documentation repository for version ${ACM_VERSION} (branch: ${BRANCH_NAME})..."
    git -C "${REPO_DIR}" fetch --quiet origin "${BRANCH_NAME}"
    git -C "${REPO_DIR}" reset --hard FETCH_HEAD
    git -C "${REPO_DIR}" clean -fdx
else
    echo "Cloning documentation for version ${ACM_VERSION} (branch: ${BRANCH_NAME})..."
    # Clone specifically into the directory we expect (openshift-docs)
    git clone --quiet --single-branch --branch "${BRANCH_NAME}" \
        https://github.com/stolostron/rhacm-docs.git "${REPO_DIR}"
fi

echo "Done."
