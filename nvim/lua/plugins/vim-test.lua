return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  config = function()
    vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", {})
    vim.keymap.set("n", "<leader>T", ":TestFile<CR>", {})
    vim.keymap.set("n", "<leader>A", ":TestSuite<CR>", {})
    vim.keymap.set("n", "<leader>l", ":TestLast<CR>", {})
    vim.keymap.set("n", "<leader>G", ":TestVisit<CR>", {})
    vim.cmd("let test#strategy = 'vimux'")
    vim.cmd("let g:VimuxOrientation = 'h'")
    vim.cmd("let g:VimuxUseNearest = 0")
  end,
}
