FROM ghcr.io/bearer/bearer:v1.3.1-amd64
COPY entrypoint.sh /entrypoint.sh
USER root
ENTRYPOINT ["/entrypoint.sh"]
