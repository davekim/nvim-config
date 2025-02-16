# nvim-config
A minimal configuration for Neovim written in Lua.

## Overview

Uses `lazy.nvim` to manage plugins.

This project will attempt to make symlinks to `~/.config/nvim`.

Backup any existing files or cleanup unnecessary files before running this
script that will create symlinks to `~/.config/nvim`.

```bash
./activate.sh
```

## Requirements

In order for treesitter `\fg` to work, you need [ripgrep](https://github.com/BurntSushi/ripgrep) installed.

```bash
brew install ripgrep
```
