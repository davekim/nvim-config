return {
  "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({ "lua", "vim", "vimdoc", "query", "ruby", "c", "python", "javascript", "html", "go" })
  end
}
