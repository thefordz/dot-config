-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- LazyVim auto format
vim.g.autoformat = true

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "auto"

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- LazyVim automatically configures lazygit:
--  * theme, based on the active colorscheme.
--  * editorPreset to nvim-remote
--  * enables nerd font icons
-- Set to false to disable.
vim.g.lazygit_config = true

-- Options for the LazyVim statuscolumn
vim.g.lazyvim_statuscolumn = {
  folds_open = false, -- show fold sign when fold is open
  folds_githl = false, -- highlight fold sign with git sign color
}

-- Optionally setup the terminal to use
-- This sets `vim.o.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
-- LazyVim.terminal.setup("pwsh")

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Show the current document symbols location from Trouble in lualine
vim.g.trouble_lualine = true

local opt = vim.opt

opt.autowrite = true -- Enable auto write
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.backspace = { "indent", "eol", "start" } -- Allow backspacing over everything in insert mode
opt.guifont = "HackGen Console NF:h18" -- Change this to whatever your font is
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect,preview"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = "-",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 0
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.spelloptions:append("noplainbuffer")
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.winblend = 0
opt.wrap = true -- Disable line wrap

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.foldcolumn = "1"
opt.foldlevelstart = 99
opt.foldenable = true

function CustomFoldTextv1()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local line_text = vim.fn.substitute(line, "\t", " ", "g")
  return string.format("%s... (%d lines)", line_text, line_count)
end

function CustomFoldTextv2()
  local line = vim.fn.getline(vim.v.foldstart) -- บรรทัดแรกของ fold
  local last_line = vim.fn.getline(vim.v.foldend) -- บรรทัดสุดท้ายของ fold

  -- เพิ่มบรรทัดว่างบนและล่าง
  local top_space = "   \n" -- เพิ่ม newline (\n) เพื่อเว้นบรรทัด
  local bottom_space = "\n   "
  local fold_display = top_space .. line .. " ... " .. last_line .. bottom_space

  return fold_display
end

function CustomFoldTextv3()
  local line = vim.fn.getline(vim.v.foldstart)
  local last_line = vim.fn.getline(vim.v.foldend)
  return line .. " ... " .. last_line
end

function CustomFoldTextv4()
  local line = vim.fn.getline(vim.v.foldstart) -- บรรทัดแรก
  local last_line = vim.fn.getline(vim.v.foldend) -- บรรทัดสุดท้าย

  -- จัดรูปแบบให้ตรงกับที่ต้องการ
  return string.format("-\n-\n%s\n...\n%s\n-\n-", line, last_line)
end

function CustomFoldTextv5()
  local line = vim.fn.getline(vim.v.foldstart) -- บรรทัดแรก
  local last_line = vim.fn.getline(vim.v.foldend) -- บรรทัดสุดท้าย

  -- จัดรูปแบบตามที่ต้องการ โดยหลีกเลี่ยงการใช้ \n
  return string.format("-\n-\n%s\n...\n%s\n-\n-", line, last_line)
end

function CustomFoldTextv6()
  local line = vim.fn.getline(vim.v.foldstart)
  local last_line = vim.fn.getline(vim.v.foldend)
  return string.format("- %s -", line)
end

vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8"
vim.o.foldtext = "v:lua.CustomFoldTextv4()" -- ใช้ v4 ตามที่ต้องการ
vim.o.foldcolumn = "1"
vim.o.foldlevelstart = 99 -- เปิดทั้งหมดโดยเริ่มต้น
vim.o.fillchars = "fold:-" -- ใช้ "-" แสดงการย่อ

-- Markdown Fix
-- vim.g.markdown_recommended_style = 0

-- ใช้ฟังก์ชันใน foldtext
-- vim.o.foldtext = "v:lua.CustomFoldText()"

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
  opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldtext = "v:lua.CustomFoldTextv6()"
  opt.foldmethod = "expr"
else
  opt.foldmethod = "indent"
  -- opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
  opt.foldtext = "v:lua.CustomFoldTextv6()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
