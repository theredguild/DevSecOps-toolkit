# Already Dockerized tools
FROM aquasec/trivy:latest AS trivy
FROM ghcr.io/trufflesecurity/trufflehog:latest AS trufflehog

FROM debian:bookworm-slim AS final

# Install tools from their Docker images
COPY --from=trivy /usr/local/bin/trivy /usr/local/bin/trivy
RUN echo "trivy" >> /tools.txt

COPY --from=trufflehog /usr/bin/trufflehog /usr/bin/trufflehog
RUN echo "trufflehog" >> /tools.txt

WORKDIR /workdir
CMD ["/bin/bash"]
