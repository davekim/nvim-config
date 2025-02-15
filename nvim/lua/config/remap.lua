-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Toggle comments
vim.keymap.set({"n", "v"}, "<leader>cc", "gc<CR>", {remap = true})
