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
                    pine = "#7f9f9f",
                    gold = "#f9bd98",
                    foam = "#bedfe0",
                    iris = "#cf637e",
                },
            },
        })
        vim.cmd("colorscheme rose-pine")
    end
}
