# nvim-config
A minimal configuration for Neovim written in Lua.

## Overview

Uses `lazy.nvim` to manage plugins and `mason.nvim` to manage LSP servers.

Plugins installed: Telescope, Treesitter, nvim-cmp, LuaSnip, nvim-tree, gitsigns, fugitive, autopairs, indent-blankline, vim-test, and LSPs for Lua, TypeScript, Ruby, and Python.

## Requirements

Install these before running `activate.sh`:

```bash
# Neovim (>= 0.9 recommended)
brew install neovim

# Node + npm — required by Mason to install ts_ls and pyright
brew install node

# ripgrep — required for Telescope live grep (\fg)
brew install ripgrep

# Git — required by lazy.nvim to fetch plugins
brew install git

# C compiler — required by Treesitter to compile parsers
# On macOS, install Xcode Command Line Tools:
xcode-select --install
```

Ruby is also configured as an LSP target (`ruby_lsp`). If you don't use Ruby, you can remove it from `nvim/lua/plugins/lsp-config.lua`.

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

`lazy.nvim` will automatically install all plugins on the first launch. After plugins finish installing, Mason will install the LSP servers (`lua_ls`, `ts_ls`, `ruby_lsp`, `pyright`) — you can monitor progress with `:Mason`.

Treesitter will compile parsers for the configured languages on first use.
