-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-------------------------------------------------------------------------------
-- LazyVim Behavior
-------------------------------------------------------------------------------
-- Set LazyVim's picker UI to Telescope
-- vim.g.lazyvim_picker = "telescope"

-------------------------------------------------------------------------------
-- UI / Display
-------------------------------------------------------------------------------
-- Show absolute line numbers
vim.opt.nu = true
-- Show relative line numbers (distance from the cursor line)
vim.opt.relativenumber = true
-- Highlight the line under the cursor
vim.opt.cursorline = true
-- Always show the sign column (prevents text shifting when signs appear)
vim.opt.signcolumn = "yes"
-- Draw a vertical guideline at columns 80 and 120
vim.opt.colorcolumn = "80,120"
-- Enable 24-bit RGB color in the terminal
vim.opt.termguicolors = true
-- Keep 8 lines visible above/below the cursor when scrolling
vim.opt.scrolloff = 8
-- Treat '@' and '-' as part of file names
vim.opt.isfname:append("@-@")
-- Don't display the current mode (Normal, Insert, etc.) in the statusline
-- (most statuslines already display this)
vim.opt.showmode = false
-- Show whitespace characters: · for space, | for tab
vim.cmd([[
set lcs=space:·
set lcs+=tab:\|\
]])
vim.opt.list = true
-- Disable line wrapping (long lines go off screen)
vim.opt.wrap = false

-------------------------------------------------------------------------------
-- Search
-------------------------------------------------------------------------------
-- Don't highlight search results after the search is complete
vim.o.hlsearch = false
-- Show matches as you type during a search
vim.opt.incsearch = true
-- Ignore case in search patterns...
vim.o.ignorecase = true
-- ...unless the pattern contains uppercase letters (then it's case-sensitive)
vim.o.smartcase = true

-------------------------------------------------------------------------------
-- Tabs / Indentation
-------------------------------------------------------------------------------
-- Number of visual spaces that a <Tab> counts for
vim.opt.tabstop = 2
-- Number of spaces inserted when pressing <Tab> in insert mode
vim.opt.softtabstop = 2
-- Number of spaces used for each step of (auto)indent
vim.opt.shiftwidth = 2
-- Use spaces instead of tabs
vim.opt.expandtab = true
-- Use 'shiftwidth' when inserting a <Tab> in insert mode
vim.opt.smarttab = true

-------------------------------------------------------------------------------
-- File Management / Persistence
-------------------------------------------------------------------------------
-- Disable swapfile creation
vim.opt.swapfile = false
-- Disable backup files
vim.opt.backup = false
-- Directory to store undo history files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- Enable persistent undo (undo history across sessions)
vim.opt.undofile = true
-- Automatically save the file before running commands like :next and :make
vim.opt.autowrite = true

-------------------------------------------------------------------------------
-- Performance
-------------------------------------------------------------------------------
-- Faster CursorHold events (in ms)
vim.opt.updatetime = 50

-------------------------------------------------------------------------------
-- Clipboard
-------------------------------------------------------------------------------
-- Don't sync Neovim's unnamed register with the system clipboard by default
vim.opt.clipboard = ""
