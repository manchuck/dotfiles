vim.o.hlsearch = false
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.cmd([[
set lcs=space:·
set lcs+=tab:\|\
]])
vim.opt.list = true

vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80,120"

vim.opt.cursorline = true

vim.opt.autowrite = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.showmode = false

vim.cmd([[
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste'  ],
  \             [ 'gitbranch', 'readonly', 'absolutepath', 'spell' ] ]
  \ },
  \ 'component_funciton': {
  \   'gitbranch': 'FugitiveHead'
  \ }
  \ }
]])
