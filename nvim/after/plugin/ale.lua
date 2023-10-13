vim.g.ale_fix_on_save = 1

vim.cmd([[
let g:ale_linters = {
\ 'python': ['flake8'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'go': ['gobuild', 'gofmt'],
\ 'rust': ['rls'],
\ 'html': ['htmlhint', 'html-beautify'],
\}
]])
vim.cmd([[
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'python': ['autopep8'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'go': ['gofmt', 'goimports'],
\ 'rust': ['rustfmt']
\}
]])

vim.keymap.set('n', '<leader>aj', vim.cmd.ALENext)
vim.keymap.set('n', '<leader>ak', vim.cmd.ALEPrevious)
