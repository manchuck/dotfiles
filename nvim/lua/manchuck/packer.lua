-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup({function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
    },
    config = function()
      require('telescope').setup({
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          }
        }
      })
      require('telescope').load_extension('undo')
      require("telescope").load_extension("advanced_git_search")
      require('telescope').load_extension('neoclip')
    end,
  }

  use {'folke/neodev.nvim'}
  -- Git related plugins
  use {'tpope/vim-fugitive'}
  use {'tpope/vim-rhubarb'}

  -- Detect tabstop and shiftwidth automatically
  use {'tpope/vim-sleuth'}

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  use {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  }

  use {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  }

  -- Useful plugin to show you pending keybinds.
  use { 'folke/which-key.nvim', opts = {} }
  use {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
  }

  -- Octo vim
  use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'nvim-tree/nvim-web-devicons',
      },
      config = function()
        require("octo").setup({
          enable_builtin = true,
        })
      end,
  }

  -- Advanced Git Search
  use {
    'aaronhallaert/advanced-git-search.nvim',
    requires = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-fugitive",
      "tpope/vim-rhubarb",
    },
    config = function()
        require("telescope").setup{
            extensions = {
                advanced_git_search = {
                }
            }
        }

    end,
  }

  -- Neoclip
  use {
    'AckslD/nvim-neoclip.lua',
    requires = {
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      },
      config = function()
        require('neoclip').setup()
      end,
  }

  -- Nord Vim
  use ({
    'arcticicestudio/nord-vim',
    as = 'nord-vim',
    config = function ()
      vim.cmd('colorscheme nord')
    end
  })


  use {'theprimeagen/harpoon'}
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
  use {
    'ThePrimeagen/refactoring.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-treesitter/nvim-treesitter'}
    }
  }

  use {'bkad/CamelCaseMotion'}

  use {'dense-analysis/ale'}

  use {'airblade/vim-gitgutter'}

  use {'prettier/vim-prettier'}

  use {'editorconfig/editorconfig-vim'}

  use {
    'akinsho/bufferline.nvim',
    tag = '*',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'buffers', -- set to 'tabs' to only show tabpages instead
          always_show_bufferline = true, -- show bufferline only when more than 1 buffer is present
          numbers = 'both',
        },
      }
    end
  }

  use { 'nelsyeung/twig.vim' }

  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use({
  "piersolenski/wtf.nvim",
    config = function()
      require("wtf").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
    }
  })

  use ({
    'mhinz/vim-startify',
  })

end,
config = {
    display= {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
