return {
  "windwp/nvim-ts-autotag",
  event = "VeryLazy",
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
      },
      filetypes = {
        "html",
        "xml",
        "javascript",
        "typescript",
        "vue",
        "jsx",
        "tsx",
        "handlebars",
        "twig",
      },
    })
  end,
}
