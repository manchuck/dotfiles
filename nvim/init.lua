-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- CamelCase the word under cursor
vim.keymap.set(
  "n",
  "<leader>cc",
  [[viw:s/\v[_-]([a-z])/\=toupper(submatch(1))/g<CR>]],
  { desc = "CamelCase word", silent = true }
)

-- CamelCase the current visual selection
vim.keymap.set(
  "v",
  "<leader>cc",
  [[:s/\v[_-]([a-z])/\=toupper(submatch(1))/g<CR>]],
  { desc = "CamelCase selection", silent = true }
)
