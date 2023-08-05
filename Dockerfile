ARG VARIANT=18-bookworm
FROM mcr.microsoft.com/devcontainers/javascript-node:1-${VARIANT}

# Install yarn latest stable version
RUN yarn set version stable

# Set up git completion in .bashrc
RUN echo "source /usr/share/bash-completion/completions/git" >> /home/node/.bashrc
