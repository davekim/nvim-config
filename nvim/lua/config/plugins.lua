-- Plugin management via vim.pack (Neovim 0.12 built-in).
-- Replaces lazy.nvim: no bootstrap, no spec DSL. We install plugins with
-- vim.pack.add({...}) and then run each plugin's setup as plain Lua.
--
-- vim.pack has no dependency resolution, so dependencies are listed BEFORE
-- their dependents (add() is synchronous; order = load order). It has no
-- per-spec merging, so the two former nvim-cmp specs are consolidated here.
-- Reproducibility is handled by vim.pack's own lockfile (vim.pack-lockfile in
-- stdpath("state")), generated on first install.

local function gh(x)
  return "https://github.com/" .. x
end

-- 1) INSTALL -----------------------------------------------------------------
-- Missing plugins are cloned on first launch (the "auto-install"). Treesitter
-- and telescope are pinned to the commits verified against Neovim 0.12.
vim.pack.add({
  -- shared dependencies, listed before the plugins that need them
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("hrsh7th/cmp-nvim-lsp"),
  gh("hrsh7th/cmp-buffer"),
  gh("hrsh7th/cmp-path"),
  gh("saadparwaiz1/cmp_luasnip"),
  gh("rafamadriz/friendly-snippets"),
  gh("L3MON4D3/LuaSnip"),
  gh("nvim-neotest/nvim-nio"),
  gh("preservim/vimux"),

  -- LSP stack: mason -> mason-lspconfig -> nvim-lspconfig
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),
  gh("neovim/nvim-lspconfig"),

  -- the rest
  gh("hrsh7th/nvim-cmp"),
  gh("nvim-telescope/telescope.nvim"),
  gh("nvim-telescope/telescope-ui-select.nvim"),
  gh("nvim-tree/nvim-tree.lua"),
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "4916d6592ede8c07973490d9322f187e07dfefac" },
  gh("lewis6991/gitsigns.nvim"),
  gh("tpope/vim-fugitive"),
  gh("tpope/vim-rails"),
  gh("vim-test/vim-test"),
  gh("lukas-reineke/indent-blankline.nvim"),
  gh("windwp/nvim-autopairs"),
  gh("mfussenegger/nvim-dap"),
  gh("leoluz/nvim-dap-go"),
  gh("rcarriga/nvim-dap-ui"),
  { src = gh("rose-pine/neovim"), name = "rose-pine" },
})

-- 2) BUILD HOOK --------------------------------------------------------------
-- Replaces lazy's `build = ":TSUpdate"`: recompile parsers when nvim-treesitter
-- is installed or updated.
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
  "lua", "vim", "vimdoc", "query", "ruby", "c", "python", "javascript", "html", "go",
})

-- completion (the two former cmp specs, merged)
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

-- LSP stack: mason -> mason-lspconfig -> nvim-lspconfig
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "ts_ls", "ruby_lsp", "pyright", "gopls" },
})
do
  -- Neovim 0.11+ native LSP API. nvim-lspconfig now only ships the server
  -- definitions (lsp/*.lua on the runtimepath); we configure and enable them
  -- via vim.lsp instead of the deprecated require("lspconfig") framework.
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
    add          = { text = "+" },
    change       = { text = "~" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  signs_staged = {
    add          = { text = "+" },
    change       = { text = "~" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true,
  numhl      = false,
  linehl     = false,
  word_diff  = false,
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
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

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
