return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- TypeScript/JavaScript LSP - renamed from tsserver to ts_ls
        ts_ls = {},
        -- PHP LSP - fast completion and navigation
        intelephense = {},
        -- YAML LSP - supports OpenAPI/Swagger schemas
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json"] = "/*",
              },
            },
          },
        },
        -- Spectral LSP - OpenAPI linting and validation
        spectral = {},
      },
    },
  },
}
