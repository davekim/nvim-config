# nvim-config
A minimal configuration for Neovim written in Lua.

## Overview

Uses `vim.pack` (Neovim's built-in plugin manager) and `mason.nvim` to manage LSP servers.

Provides LSP completion, syntax highlighting, file navigation, Git integration, testing via tmux, and Go debugging out of the box.

## Requirements

**Neovim >= 0.11** is required (the current `nvim-treesitter` drops the `configs` module and relies on built-in Treesitter highlighting). Tested on 0.12.3.

Install these before running `activate.sh`:

```bash
# Neovim
brew install neovim

# Node + npm — required by Mason to install ts_ls and pyright
brew install node

# ripgrep — required for Telescope live grep (\fg)
brew install ripgrep

# Git — required by vim.pack to fetch plugins
brew install git

# C compiler — required by Treesitter to compile parsers
# On macOS, install Xcode Command Line Tools:
xcode-select --install

# tree-sitter CLI — required by nvim-treesitter to build parsers
# (the `tree-sitter` formula is only the library; the CLI is separate)
brew install tree-sitter-cli

# Go — required by gopls (LSP) and nvim-dap-go (debugger)
brew install go

# tmux — required by vimux, which vim-test uses to run tests
brew install tmux
```

Ruby is also configured as an LSP target (`ruby_lsp`). Ruby must be installed on the machine for Mason to install it. If you don't use Ruby, you can remove it from `nvim/lua/plugins/lsp-config.lua`.

## Install

Backup or remove any existing Neovim config, then run:

```bash
./activate.sh
```

This creates symlinks from `~/.config/nvim` to this repo.

## First Launch

Open Neovim:

```bash
nvim
```

`vim.pack` will automatically install all plugins on the first launch. Mason will then install the configured LSP servers — monitor progress with `:Mason`. Treesitter parsers compile on first use.
