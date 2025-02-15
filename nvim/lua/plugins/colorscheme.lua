return {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
            variant = "main",
            dark_variant = "main",
            palette = {
                main = {
                    base = "#1e1e1e",
                    pine = "#728296",
                    gold = "#f9bd98",
                    foam = "#bacacc",
                    iris = "#cf637e",
                },
            },
            groups = {
                git_add = "#a6da95",
                git_change = "gold",
                git_delete = "love",
            },
            highlight_groups = {
                TelescopeBorder = { fg = "highlight_high", bg = "none" },
                TelescopeNormal = { bg = "none" },
                TelescopePromptNormal = { bg = "base" },
                TelescopeResultsNormal = { fg = "subtle", bg = "none" },
                TelescopeSelection = { fg = "text", bg = "base" },
                TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
            }
        })
        vim.cmd("colorscheme rose-pine")
    end
}
