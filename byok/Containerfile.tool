ARG UBI_BASE_IMAGE=registry.access.redhat.com/ubi9/ubi:latest
FROM ${UBI_BASE_IMAGE}
ARG LOG_LEVEL=info
ARG OUT_IMAGE_TAG=byok-image
ARG VECTOR_DB_INDEX=vector_db_index
ARG UBI_BASE_IMAGE
ARG WORKERS=0
ARG UNREACHABLE_ACTION=warn

RUN dnf install -y buildah python3.12 python3.12-pip git && dnf clean all

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

USER 0
WORKDIR /workdir

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-cache

# Download the model
COPY embedding_generator/scripts/download_embeddings_model.py embedding_generator/scripts/
RUN mkdir -p embeddings_model && \
    uv run python embedding_generator/scripts/download_embeddings_model.py -l embeddings_model -r sentence-transformers/all-mpnet-base-v2

COPY embedding_generator ./embedding_generator
COPY byok/entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

LABEL com.redhat.component=acm-rag-content
LABEL description="ACM BYO Knowledge Tools"
LABEL distribution-scope=private
LABEL io.k8s.description="ACM BYO Knowledge Tools"
LABEL io.k8s.display-name="ACM BYO Knowledge Tools"
LABEL io.openshift.tags="openshift,lightspeed,ai,assistant,rag,acm"
LABEL name="acm-rag-tool"
LABEL release=0.0.1
LABEL vendor="Red Hat, Inc."
LABEL version=0.0.1
LABEL summary="ACM BYO Knowledge Tools"
LABEL konflux.additional-tags="latest"

ENV _BUILDAH_STARTED_IN_USERNS=""
ENV BUILDAH_ISOLATION=chroot
ENV OUT_IMAGE_TAG="${OUT_IMAGE_TAG}"
ENV UBI_BASE_IMAGE="${UBI_BASE_IMAGE}"
ENV LOG_LEVEL="${LOG_LEVEL}"
ENV VECTOR_DB_INDEX="${VECTOR_DB_INDEX}"
ENV DOCS_VERSION=byok
ENV WORKERS="${WORKERS}"
ENV UNREACHABLE_ACTION="${UNREACHABLE_ACTION}"

CMD ["./entrypoint.sh"]
