ARG VARIANT=18-bookworm
FROM mcr.microsoft.com/devcontainers/javascript-node:1-${VARIANT}

# Install yarn latest
RUN corepack enable && \
    corepack prepare yarn@stable --activate && \
    corepack disable
