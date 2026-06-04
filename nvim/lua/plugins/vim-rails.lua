return {
    "tpope/vim-rails",
    config = function()
        vim.keymap.set("n", "<leader>av", ":AV<CR>", {}) -- toggle spec/test counterpart (vertical split)
        vim.keymap.set("n", "<leader>ah", ":AS<CR>", {}) -- toggle spec/test counterpart (horizontal split)
    end
}
