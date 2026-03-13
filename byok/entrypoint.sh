#!/bin/bash
set -eo pipefail

uv run python embedding_generator/custom_processor.py \
    -o vector_db \
    -f /markdown \
    -md embeddings_model \
    -mn sentence-transformers/all-mpnet-base-v2 \
    -i "${VECTOR_DB_INDEX}" \
    --config embedding_generator/config.yaml \
    --product acm \
    --version "${DOCS_VERSION}" \
    --vector-store-type faiss \
    --workers "${WORKERS:-0}" \
    --unreachable-action "${UNREACHABLE_ACTION:-warn}" \
    --log-level "${LOG_LEVEL:-info}"

echo "FROM ${UBI_BASE_IMAGE}" > Containerfile.package
echo "COPY vector_db /rag/vector_db" >> Containerfile.package

BUILD_ARGS=()
if [ -n "${PLATFORM}" ]; then
    BUILD_ARGS+=("--platform" "${PLATFORM}")
fi

buildah --log-level "${LOG_LEVEL}" build "${BUILD_ARGS[@]}" -t "localhost/${OUT_IMAGE_TAG}:latest" -f Containerfile.package .

rm -f "/output/${OUT_IMAGE_TAG}.tar"
buildah push "localhost/${OUT_IMAGE_TAG}:latest" "docker-archive:/output/${OUT_IMAGE_TAG}.tar"
