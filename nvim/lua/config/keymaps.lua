-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del({ "n" }, "<S-l>")
vim.keymap.del({ "n" }, "<S-h>")
vim.keymap.del({ "i" }, "<CR>")

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
