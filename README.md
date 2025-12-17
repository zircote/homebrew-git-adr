# zircote Homebrew Tap

Official [Homebrew](https://brew.sh/) tap for zircote projects.

## Available Formulae

| Formula | Description |
|---------|-------------|
| [git-adr](https://github.com/zircote/git-adr) | Architecture Decision Records management using git notes |

## Installation

```bash
# Add this tap
brew tap zircote/tap

# Install a formula
brew install git-adr
```

Or install directly:

```bash
brew install zircote/tap/git-adr
```

## Updating

```bash
brew update
brew upgrade git-adr
```

## Uninstalling

```bash
brew uninstall git-adr
brew untap zircote/tap
```

## Post-Installation

To use git-adr as a git subcommand, add a git alias:

```bash
git config --global alias.adr '!git-adr'
```

Then you can use: `git adr new "My Decision"`

## What is git-adr?

git-adr is a CLI tool for managing Architecture Decision Records (ADRs) using git notes instead of files in your repository. This approach:

- Keeps your working tree clean (no ADR files)
- Integrates seamlessly with git workflows
- Survives rebases and amends
- Can be synced across remotes

Learn more at [github.com/zircote/git-adr](https://github.com/zircote/git-adr)

## Issues

For issues with a formula (installation, updates), please open an issue in this repository.

For issues with the tools themselves, please open an issue in the respective project repository.
