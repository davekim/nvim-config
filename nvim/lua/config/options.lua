-- Edit
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ruler = true
vim.opt.wrap = true
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200

local function statusline()
  local start = "%<"
  local buffer_number_and_flags = "%2*[%n%H%M%R%W]%*"
  local relative_path = "%-40f"
  local right_and_left_aligned = "%="
  local file_type = "%1*%y%*%*"
  local line = "%10(L(%l/%L)%)"
  local column = "%2(C(%v/125)%)"
  local percentage_of_file = "%P"

  return string.format(
    "%s%s%s%s%s%s%s%s",
    start,
    buffer_number_and_flags,
    relative_path,
    right_and_left_aligned,
    file_type,
    line,
    column,
    percentage_of_file
  )
end

vim.opt.laststatus = 2 -- 2 for always, 3 for one global bar
vim.opt.statusline = statusline()

-- enable 24-bit colour
vim.opt.termguicolors = true

-- line number
vim.wo.number = true
