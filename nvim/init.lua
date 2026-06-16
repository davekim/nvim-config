-- Enable the Lua module bytecode cache. Must run before any require().
vim.loader.enable()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('config.remap')
require('config.options')
require('config.plugins')
