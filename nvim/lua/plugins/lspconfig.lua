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

    -- import mason registry for typescript support
    local mason_registry = require("mason-registry")
    local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
      .. "/node_modules/@vue/language-server"

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
    lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })

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
      on_attach = on_attach,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("format_js_ts_on_save", { clear = true }),
      pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
      callback = function(args)
        vim.lsp.buf.format({
          bufnr = args.buf,
          async = false,
          timeout_ms = 2000,
        })
      end,
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
      group = vim.api.nvim_create_augroup("format_js_ts_on_save", { clear = true }),
      pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
      callback = function(args)
        vim.lsp.buf.format({
          bufnr = args.buf,
          async = false,
          timeout_ms = 2000,
        })
      end,
    })

    ---------------------------------------------------------------------------
    -- JSON with SchemaStore
    ---------------------------------------------------------------------------
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    -- Helper function to format with jsonls only
    local function lsp_fmt_json(buf)
      vim.lsp.buf.format({
        bufnr = buf,
        async = false,
        timeout_ms = 2000,
        filter = function(client)
          return client.name == "jsonls"
        end,
      })
    end

    -- Format JSON on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("json_lsp_format_on_save", { clear = true }),
      pattern = { "*.json", "*.jsonc" },
      callback = function(args)
        lsp_fmt_json(args.buf)
      end,
    })

    -- Format JSON when leaving insert mode (with a small debounce to avoid jitter)
    vim.api.nvim_create_autocmd("InsertLeave", {
      group = vim.api.nvim_create_augroup("json_lsp_format_on_insertleave", { clear = true }),
      pattern = { "*.json", "*.jsonc" },
      callback = function(args)
        local key = "json_lsp_timer"
        local t = vim.b[key]
        if t then
          t:stop()
          t:close()
        end
        t = vim.loop.new_timer()
        vim.b[key] = t
        t:start(150, 0, function()
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
              lsp_fmt_json(args.buf)
            end
          end)
        end)
      end,
    })

    ---------------------------------------------------------------------------
    -- TypeScript / JavaScript / Node via vtsls (recommended over tsserver)
    ---------------------------------------------------------------------------
    lspconfig.vtsls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        -- Run ESLint fix when leaving insert mode
        vim.api.nvim_create_autocmd("InsertLeave", {
          buffer = bufnr,
          command = "EslintFixAll",
        })

        -- Run ESlint fix when writing the file
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
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
      -- You can include Vue in filetypes if needed, but Volar handles Vue better.
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    })

    ---------------------------------------------------------------------------
    -- PHP (pick ONE: phpactor OR intelephense)
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
