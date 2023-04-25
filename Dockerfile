FROM ghcr.io/bearer/bearer:latest-amd64
COPY entrypoint.sh /entrypoint.sh
USER root
ENTRYPOINT ["/entrypoint.sh"]
