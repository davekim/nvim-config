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
        })
        vim.cmd("colorscheme rose-pine")
    end
}
