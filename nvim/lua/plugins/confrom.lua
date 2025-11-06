return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    format_on_save = function(bufnr)
      -- Only auto-format on save if file is not too large
      local max_size = 256 * 1024 -- 256KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
      if ok and stats and stats.size > max_size then
        return false
      end
      return { timeout_ms = 2000, lsp_fallback = true }
    end,
    formatters_by_ft = {
      html = { "prettier" },
      htmldjango = { "prettier" },
      hbs = { "prettier" },
      handlebars = { "prettier" },
      twig = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      php = { "prettier" },
      scss = { "prettier" },
      css = { "prettier" },
    },
  },
}
