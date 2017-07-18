FROM alpine:3.5

# Set up HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
    CMD \
    exit 0 || exit 1

RUN \
    mkdir -p /website/bootstrap/cache && \
    mkdir -p /website/storage/app && \
    mkdir -p /website/storage/app/public && \
    mkdir -p /website/storage/framework && \
    mkdir -p /website/storage/framework/cache && \
    mkdir -p /website/storage/framework/sessions && \
    mkdir -p /website/storage/framework/testing && \
    mkdir -p /website/storage/framework/views && \
    mkdir -p /website/storage/logs  && \
    chmod 777 -R /website/storage && \
    chmod 777 -R /website/bootstrap/cache

VOLUME /website/storage
VOLUME /website/bootstrap/cache

CMD /bin/sh