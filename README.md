# gt-dev-container

GT dev container to be used in local vscode and codespaces. Note that this is a public image that does not contain any sensitive information.

## Environment

Base image: `mcr.microsoft.com/devcontainers/base:bookworm`

- Common utilities: oh-my-zsh, non-root user(`gt-dev`), etc.
- Git + LFS
- GitHub CLI
- Node.js + PNPM
- Python + PDM

## Definitions

More detail in the [config file](./.devcontainer.json).

## License

MIT, more details [here](./LICENSE)
