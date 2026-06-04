return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            signs = {
                add          = { text = '+' },
                change       = { text = '~' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged = {
                add          = { text = '+' },
                change       = { text = '~' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged_enable = true,
            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                follow_files = true
            },
            auto_attach = true,
            attach_to_untracked = false,
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                local opts = { buffer = bufnr }
                vim.keymap.set("n", "]c", gs.next_hunk, opts)
                vim.keymap.set("n", "[c", gs.prev_hunk, opts)
                vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
                vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
                vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
                vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts)
            end
        })
    end
}
