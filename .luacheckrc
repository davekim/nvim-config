-- Neovim runs LuaJIT and exposes the global `vim` API. Use `globals` (not
-- `read_globals`) so assigning fields like `vim.opt.x = ...` isn't flagged.
std = "luajit"
globals = { "vim" }
