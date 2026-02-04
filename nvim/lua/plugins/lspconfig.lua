return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    format = {
      enable = true,
      defaultConfig = {
        indent_style = "space",
        indent_size = "2",
      },
    },
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    ---------------------------------------------------------------------------
    -- Web: HTML/CSS/Tailwind/Emmet/ESLint
    ---------------------------------------------------------------------------

    -- configure html server
    lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })

    -- configure css server
    lspconfig.cssls.setup({ 
      capabilities = capabilities, 
      on_attach = on_attach,
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
    })

    -- configure tailwindcss server
    lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })

    -- configure emmet language server
    lspconfig["emmet_language_server"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "php", "vue", "css", "html", "javascript", "ts_ls", "less", "sass", "scss" },
    })

    -- ESLint (for JS/TS/HTML/etc.)
    lspconfig.eslint.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
      end,
    })

    ---------------------------------------------------------------------------
    -- YAML
    ---------------------------------------------------------------------------
    lspconfig.yamlls.setup{
      on_attach = on_attach,
      capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      settings = {
        yaml = {
          format = {
            enable = true,
            singleQuote = true,
            bracketSpacing = true,
            proseWrap = true,
          },
          schemas = {
            ["https://www.schemastore.org/openapi-3.X.json"]= "/Users/creeves/Projects/vonage/api/api-specification/*",
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
          },
          validate = true,
          hover = true,
          completion = true,
        }
      }
    }

    ---------------------------------------------------------------------------
    -- JSON with SchemaStore
    ---------------------------------------------------------------------------
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        -- Format on save only (primary trigger)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              async = false,
              timeout_ms = 2000,
            })
          end,
        })

        -- Safe format on leaving insert mode
        local function safe_format(buf)
          local clients = vim.lsp.get_active_clients({ bufnr = buf })
          if #clients == 0 then return end
          vim.schedule(function()
            if not vim.api.nvim_buf_get_option(buf, "modified") then return end
            vim.lsp.buf.format({
              bufnr = buf,
              async = false,
              timeout_ms = 1500,
              filter = function(c)
                return c.name == "jsonls"
              end,
            })
          end)
        end

        vim.api.nvim_create_autocmd("InsertLeave", {
          buffer = bufnr,
          callback = function(args)
            safe_format(args.buf)
          end,
        })

        -- Better navigation + hover
        local keymap = vim.keymap
        keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition ($ref)" })
        keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Show schema info" })
      end,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
          format = { enable = true },
        },
      },
    })

    ---------------------------------------------------------------------------
    -- TypeScript / JavaScript / Node via vtsls (recommended over tsserver)
    ---------------------------------------------------------------------------
    lspconfig.vtsls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        local function safe_format(buf)
          local clients = vim.lsp.get_active_clients({ bufnr = buf })
          if #clients == 0 then return end
          vim.schedule(function()
            if not vim.api.nvim_buf_get_option(buf, "modified") then return end
            vim.lsp.buf.format({
              bufnr = buf,
              async = false,
              timeout_ms = 1500,
              filter = function(c)
                return c.name == "vtsls"
              end,
            })
          end)
        end

        -- ESLint fix + VTSLS format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.cmd("silent! EslintFixAll")
            safe_format(bufnr)
          end,
        })

        -- ESLint fix + VTSLS format when leaving insert mode
        vim.api.nvim_create_autocmd("InsertLeave", {
          buffer = bufnr,
          callback = function(args)
            vim.cmd("silent! EslintFixAll")
            safe_format(args.buf)
          end,
        })
      end,
      settings = {
        vtsls = { tsserver = { globalPlugins = {} } },
        typescript = {
          preferences = { importModuleSpecifier = "non-relative" },
          inlayHints = { includeInlayParameterNameHints = "all" },
        },
        javascript = {
          inlayHints = { includeInlayParameterNameHints = "all" },
        },
      },
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    })

    ---------------------------------------------------------------------------
    -- PHP
    ---------------------------------------------------------------------------

    lspconfig.phpactor.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    ---------------------------------------------------------------------------
    -- Python: basedpyright (or pyright) + ruff_lsp
    ---------------------------------------------------------------------------
    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = { analysis = { typeCheckingMode = "standard" } },
      },
    })

    lspconfig.ruff_lsp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    ---------------------------------------------------------------------------
    -- Bash
    ---------------------------------------------------------------------------
    lspconfig.bashls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    ---------------------------------------------------------------------------
    -- Lua
    ---------------------------------------------------------------------------
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
}
