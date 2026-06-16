-- Set `mapleader` and `maplocalleader` before plugins load so mappings
-- are correct. This is also a good place to set other options (vim.opt).
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Toggle comments
vim.keymap.set("n", "<leader>cc", "gcc", { remap = true })
vim.keymap.set("v", "<leader>cc", "gc", { remap = true })
