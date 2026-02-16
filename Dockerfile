# syntax=docker/dockerfile:1
FROM mambaorg/micromamba:2.5.0

# Build-time toggle for cq-cli
ARG INSTALL_CQ_CLI=1

# Runtime defaults
ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Follow micromamba-docker recommended pattern: COPY env.yaml + micromamba install. :contentReference[oaicite:7]{index=7}
COPY --chown=$MAMBA_USER:$MAMBA_USER conda/env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes

# Optional: install cq-cli (from GitHub via pip+git). :contentReference[oaicite:8]{index=8}
COPY --chown=$MAMBA_USER:$MAMBA_USER pip/requirements-cq-cli.txt /tmp/requirements-cq-cli.txt
RUN if [ "$INSTALL_CQ_CLI" = "1" ]; then \
      micromamba run -n base pip install -r /tmp/requirements-cq-cli.txt; \
    fi

WORKDIR /work

# Keep micromamba image ENTRYPOINT (it activates the env for docker run). :contentReference[oaicite:9]{index=9}
CMD ["python"]
