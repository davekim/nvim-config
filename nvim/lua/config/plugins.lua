-- Plugin management with vim.pack: install plugins with vim.pack.add({...}),
-- then configure each one as plain Lua below.
--
-- Dependencies must be listed before the plugins that need them -- add() is
-- synchronous, so list order is load order. Pinned revisions are recorded in
-- nvim-pack-lock.json (next to init.lua), written on first install.

local function gh(x)
  return "https://github.com/" .. x
end

-- 1) INSTALL -----------------------------------------------------------------
-- Every plugin is pinned to an exact commit so installs are deterministic
-- regardless of the lockfile's presence. To update a plugin, bump its version
-- to a newer commit (review the diff first).
vim.pack.add({
  -- shared dependencies, listed before the plugins that need them
  { src = gh("nvim-lua/plenary.nvim"), version = "74b06c6c75e4eeb3108ec01852001636d85a932b" },
  { src = gh("nvim-tree/nvim-web-devicons"), version = "dfbfaa967a6f7ec50789bead7ef87e336c1fa63c" },
  { src = gh("hrsh7th/cmp-nvim-lsp"), version = "cbc7b02bb99fae35cb42f514762b89b5126651ef" },
  { src = gh("hrsh7th/cmp-buffer"), version = "b74fab3656eea9de20a9b8116afa3cfc4ec09657" },
  { src = gh("hrsh7th/cmp-path"), version = "c642487086dbd9a93160e1679a1327be111cbc25" },
  { src = gh("saadparwaiz1/cmp_luasnip"), version = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90" },
  { src = gh("rafamadriz/friendly-snippets"), version = "6cd7280adead7f586db6fccbd15d2cac7e2188b9" },
  { src = gh("L3MON4D3/LuaSnip"), version = "0abc8f390b278c3b4aabc4c004ac8a088b65cf24" },
  { src = gh("nvim-neotest/nvim-nio"), version = "21f5324bfac14e22ba26553caf69ec76ae8a7662" },
  { src = gh("preservim/vimux"), version = "d6cb7f63a8bb428ffc27060b7f83c77fb115589c" },

  -- LSP stack: mason -> mason-lspconfig -> nvim-lspconfig
  { src = gh("williamboman/mason.nvim"), version = "2a6940af80375532e5e9e7c1f2fc6319a1b7a69d" },
  { src = gh("williamboman/mason-lspconfig.nvim"), version = "21c5b3ebeaa0412e28096bb0701434c51c1fbf76" },
  { src = gh("neovim/nvim-lspconfig"), version = "a683e0ddf0cf64c6cd689e18ffb480ade3c162b7" },

  -- the rest
  { src = gh("hrsh7th/nvim-cmp"), version = "a1d504892f2bc56c2e79b65c6faded2fd21f3eca" },
  { src = gh("nvim-telescope/telescope.nvim"), version = "7d324792b7943e4aa16ad007212e6acc6f9fe335" },
  { src = gh("nvim-telescope/telescope-ui-select.nvim"), version = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2" },
  { src = gh("nvim-tree/nvim-tree.lua"), version = "fb343438d49fba8c35ecc4829d66fca7a1f0ed3d" },
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "4916d6592ede8c07973490d9322f187e07dfefac" },
  { src = gh("lewis6991/gitsigns.nvim"), version = "25050e4ed39e628282831d4cbecb1850454ce915" },
  { src = gh("tpope/vim-fugitive"), version = "3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0" },
  { src = gh("tpope/vim-rails"), version = "b0a5c76f86ea214ade36ab0b811e730c3f0add67" },
  { src = gh("vim-test/vim-test"), version = "2676d84c6901e484df00b5d728bd6a345d47ee12" },
  { src = gh("lukas-reineke/indent-blankline.nvim"), version = "d28a3f70721c79e3c5f6693057ae929f3d9c0a03" },
  { src = gh("windwp/nvim-autopairs"), version = "7b9923abad60b903ece7c52940e1321d39eccc79" },
  { src = gh("mfussenegger/nvim-dap"), version = "531771530d4f82ad2d21e436e3cc052d68d7aebb" },
  { src = gh("leoluz/nvim-dap-go"), version = "b4421153ead5d726603b02743ea40cf26a51ed5f" },
  { src = gh("rcarriga/nvim-dap-ui"), version = "1a66cabaa4a4da0be107d5eda6d57242f0fe7e49" },
  { src = gh("rose-pine/neovim"), name = "rose-pine", version = "ff483051a47e27d84bdef47703538df1ed9f4a47" },
})

-- 2) BUILD HOOK --------------------------------------------------------------
-- Recompile parsers whenever nvim-treesitter is installed or updated.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind ~= "delete" then
      vim.cmd("TSUpdate")
    end
  end,
})

-- 3) SETUP -------------------------------------------------------------------

-- colorscheme (rose-pine)
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
      surface = "#242323",
    },
  },
  groups = {
    git_add = "#a6da95",
    git_change = "gold",
    git_delete = "love",
  },
  highlight_groups = {
    Visual = { bg = "subtle", blend = 15 },
    NvimTreeCursorLine = { bg = "subtle", blend = 15 },
    TelescopeBorder = { fg = "highlight_high", bg = "none" },
    TelescopeNormal = { bg = "none" },
    TelescopePromptNormal = { bg = "base" },
    TelescopeResultsNormal = { fg = "subtle", bg = "none" },
    TelescopeSelection = { fg = "text", bg = "base" },
    TelescopeSelectionCaret = { fg = "foam", bg = "foam" },
  },
})
vim.cmd("colorscheme rose-pine")

-- treesitter (parser install is idempotent; highlight/indent are 0.12 built-ins)
require("nvim-treesitter").install({
  "lua",
  "vim",
  "vimdoc",
  "query",
  "ruby",
  "c",
  "python",
  "javascript",
  "html",
  "go",
})

-- completion. Deferred to the first InsertEnter so the completion stack
-- (cmp + LuaSnip + friendly-snippets) isn't loaded until it's needed.
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
})

-- LSP stack: mason -> mason-lspconfig -> nvim-lspconfig
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "ruby_lsp", "pyright", "gopls" },
})
do
  -- Configure servers via the native vim.lsp API. nvim-lspconfig provides the
  -- server definitions (lsp/*.lua on the runtimepath); vim.lsp.config sets
  -- options and vim.lsp.enable starts them.
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  vim.lsp.config("*", { capabilities = capabilities })
  vim.lsp.config("gopls", {
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  })
  vim.lsp.enable({ "lua_ls", "ts_ls", "ruby_lsp", "pyright", "gopls" })

  -- format Go files with gopls before saving
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })

  vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
  vim.keymap.set("n", "<leader>bd", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
  vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
end

-- telescope (+ ui-select extension)
require("telescope").setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({}),
    },
  },
})
require("telescope").load_extension("ui-select")
do
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  vim.keymap.set("n", "<leader>be", builtin.buffers, {})
end

-- nvim-tree
require("nvim-tree").setup({
  filters = {
    dotfiles = false,
  },
  view = {
    signcolumn = "no",
  },
})
vim.keymap.set("n", "<leader>nt", "<cmd>NvimTreeToggle<CR>", {})
vim.keymap.set("n", "<leader>nf", "<cmd>NvimTreeFindFile<CR>", {})
require("nvim-tree.api").events.subscribe("TreeOpen", function()
  vim.wo.statusline = " "
end)

-- gitsigns
require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    follow_files = true,
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
  end,
})

-- indent-blankline (module name is "ibl")
require("ibl").setup({
  indent = {
    char = "▏",
  },
  scope = {
    enabled = false,
    char = "▏",
    show_start = false,
    show_end = false,
  },
})

-- autopairs
require("nvim-autopairs").setup({})

-- dap (Go) + dap-ui
do
  local dap = require("dap")
  local dap_go = require("dap-go")
  local dapui = require("dapui")

  dap_go.setup()
  dapui.setup()

  -- open/close UI automatically when a debug session starts and ends
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  vim.keymap.set("n", "<leader>dt", dap_go.debug_test, { desc = "Debug nearest Go test" })
  vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
  vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
  vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step over" })
  vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
  vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
  vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
end

-- vim-test (via vimux)
vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", {})
vim.keymap.set("n", "<leader>T", ":TestFile<CR>", {})
vim.keymap.set("n", "<leader>A", ":TestSuite<CR>", {})
vim.keymap.set("n", "<leader>l", ":TestLast<CR>", {})
vim.keymap.set("n", "<leader>G", ":TestVisit<CR>", {})
vim.cmd("let test#strategy = 'vimux'")
vim.cmd("let g:VimuxOrientation = 'h'")
vim.cmd("let g:VimuxUseNearest = 0")

-- vim-rails
vim.keymap.set("n", "<leader>av", ":AV<CR>", {}) -- toggle spec/test counterpart (vertical split)
vim.keymap.set("n", "<leader>ah", ":AS<CR>", {}) -- toggle spec/test counterpart (horizontal split)

-- fugitive
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
