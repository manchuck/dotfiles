if true then return {} end

return {
  "phpactor/phpactor",
  build = "composer install --no-dev --optimize-autoloader",
  ft = "php", -- Only load for PHP files
  keys = {
    { "<leader>pm", "<cmd>PhpactorContextMenu<cr>", desc = "Phpactor context menu" },
    { "<leader>pn", "<cmd>PhpactorClassNew<cr>", desc = "Create new class" },
    { "<leader>pe", "<cmd>PhpactorExtractExpression<cr>", desc = "Extract expression" }, 
    { "<leader>pv", "<cmd>PhpactorExtractMethod<cr>", desc = "Extract method" },
    { "<leader>pr", "<cmd>PhpactorMoveFile<cr>", desc = "Move/rename file" },
    { "<leader>pc", "<cmd>PhpactorCopyFile<cr>", desc = "Copy file" },
    { "<leader>pg", "<cmd>PhpactorGenerateAccessor<cr>", desc = "Generate getter" },
    { "<leader>ps", "<cmd>PhpactorGenerateAccessors<cr>", desc = "Generate getters & setters" },
    { "<leader>pu", "<cmd>PhpactorImportClass<cr>", desc = "Import class under cursor" },
    { "<leader>pa", "<cmd>PhpactorImportMissingClasses<cr>", desc = "Import all missing classes" },
    { "<leader>pp", "<cmd>PhpactorTransform<cr>", desc = "Transform (general refactoring)" },
  },
  config = function()
    -- Phpactor configuration
    vim.g.phpactorOmniError = true
    vim.g.phpactorCompletionIgnoreCase = 0

    -- Don't conflict with LSP completion
    vim.g.phpactorUseOpenWindows = 1
  end
}
