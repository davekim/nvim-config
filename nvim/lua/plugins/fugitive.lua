return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>gd", function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.api.nvim_buf_get_name(buf):match("^fugitive://") then
                    vim.api.nvim_win_close(win, false)
                    return
                end
            end
            vim.cmd.Gdiffsplit()
        end)
        vim.keymap.set("n", "<leader>gb", function()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "fugitiveblame" then
                    vim.api.nvim_win_close(win, false)
                    return
                end
            end
            vim.cmd.Git("blame")
        end)
    end
}
