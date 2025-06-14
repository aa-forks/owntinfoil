FROM python:3.12-slim as base

LABEL org.opencontainers.image.source="https://github.com/jag-k/owntinfoil"
LABEL org.opencontainers.image.description="OwnTinfoil Image"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Jag_k"
LABEL org.opencontainers.image.url="https://github.com/jag-k/owntinfoil"
LABEL org.opencontainers.image.documentation="https://github.com/jag-k/owntinfoil/wiki"
LABEL org.opencontainers.image.vendor="Jag_k"

ENV PIP_DEFAULT_TIMEOUT=100 \
    # Allow statements and log messages to immediately appear
    PYTHONUNBUFFERED=1 \
    # disable a pip version check to reduce run-time & log-spam
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    # cache is useless in docker image, so disable to reduce image size
    PIP_NO_CACHE_DIR=1
ENV PYTHONPATH=/app
WORKDIR $PYTHONPATH

FROM base as builder

ARG POETRY_VERSION=1.8.2
RUN pip install "poetry==$POETRY_VERSION"

COPY pyproject.toml poetry.lock ./

# Set poetry config to install packages in /venv/project/lib/python3.12/site-packages
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --only main
#    poetry config virtualenvs.prompt "project" && \


FROM base as final

ENV NPS_DIR=/nps
ENV TORRENT_DIR=/torrents

# Copy python side-packages from builder
# RUN mkdir -p "/usr/local/lib/python3.12/site-packages"
COPY --from=builder "/usr/local/lib/python3.12/site-packages" "/usr/local/lib/python3.12/site-packages"

COPY . $PYTHONPATH

#ENTRYPOINT ["/bin/bash"]
CMD ["python", "app/main.py"]
