return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        filters = {
          dotfiles = false,
        },
        view = {
          signcolumn = "no"
        }
      })
      vim.keymap.set("n", "<leader>nt", "<cmd>NvimTreeToggle<CR>", {})
    end
}
