FROM alpine:3.5

# Set up HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
    CMD \
    exit 0 || exit 1

RUN \
    mkdir -p /website/storage && \
    chmod 777 -R /website/storage

VOLUME /website/storage

CMD /bin/sh