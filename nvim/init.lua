-- Lua module bytecode cache (lazy.nvim enables this automatically; vim.pack
-- does not, so we do it ourselves). Must run before any require().
vim.loader.enable()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("config.remap")
require("config.options")
require("config.plugins")
