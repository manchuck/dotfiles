vim.cmd([[
let s:header_cmd =
  \ 'chuck --no-cow | cowsay -W 80 '
let g:startify_custom_header =
  \ startify#center(split(system(s:header_cmd), '\n'))
]])
