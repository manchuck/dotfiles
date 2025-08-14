return {
  -- Core Copilot (inline suggestions)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      panel = { enabled = false }, -- disable side panel, keep inline suggestions
      suggestion = {
        enabled = true,
        auto_trigger = true, -- show suggestions as you type
        debounce = 75,
        keymap = {
          accept = "<M-l>", -- Alt-l to accept
          next = "<M-]>", -- Alt-]
          prev = "<M-[>", -- Alt-[
          dismiss = "<C-]>", -- Ctrl-]
        },
      },
      filetypes = {
        markdown = false, -- example: disable in Markdown
        help = false,
        gitcommit = true,
        ["*"] = true, -- enable everywhere else
      },
    },
  },

  -- OPTIONAL: integrate Copilot as a completion source for nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    opts = {},
    config = function(_, opts)
      require("copilot").setup() -- ensure core is initialized
      require("copilot_cmp").setup(opts)
      -- add copilot to your cmp sources (low priority so LSP stays first)
      local ok, cmp = pcall(require, "cmp")
      if ok then
        cmp.setup({
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "buffer" },
            { name = "copilot", group_index = 2, priority = 50 },
          }),
        })
      end
    end,
  },
}
