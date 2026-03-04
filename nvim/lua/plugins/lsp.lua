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
                ["https://www.schemastore.org/openapi-3.X.json"] = "/*",
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
