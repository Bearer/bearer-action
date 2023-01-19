FROM ghcr.io/bearer/curio:latest-amd64
COPY entrypoint.sh /entrypoint.sh
USER root
ENTRYPOINT ["/entrypoint.sh"]