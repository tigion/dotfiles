-- Bootstrapping packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

local status, packer = pcall(require, 'packer')
if not status then
  print 'Packer is not installed'
  return
end

vim.cmd [[ packadd packer.nvim ]]

packer.startup(function(use)
  -- packer manager itself
  use 'wbthomason/packer.nvim'

  -- colorschemes
  use {
    'svrana/neosolarized.nvim', -- truecolor, solarized dark colorscheme
    requires = { 'tjdevries/colorbuddy.nvim' }, -- colorscheme helper
  }

  -- layout
  use 'nvim-lualine/lualine.nvim' -- statusline
  --use 'nvim-lua/plenary.nvim' -- common utilities
  use 'nvim-tree/nvim-web-devicons' -- file icons
  use 'folke/zen-mode.nvim' -- distraction-free coding
  use 'lukas-reineke/indent-blankline.nvim' -- highlight indention level
  use {
    'akinsho/bufferline.nvim', -- styled tabs
    requires = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
  }
  use {
    'nvim-tree/nvim-tree.lua', -- file explorer
    requires = 'nvim-tree/nvim-web-devicons', -- optional, for file icons
  }

  -- coding helper
  use 'windwp/nvim-autopairs' -- auto pairs (cmp, treesitter)
  use 'windwp/nvim-ts-autotag' -- auto tags
  use 'norcalli/nvim-colorizer.lua' -- colored color codes
  use {
    'numToStr/Comment.nvim', -- comment handling
    requires = 'JoosepAlviste/nvim-ts-context-commentstring', -- support embedded languages
  }
  use 'ethanholz/nvim-lastplace' -- reopen files at last edit position
  use 'mhartington/formatter.nvim' -- format / indent (:Format)

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter', -- treesitter
    run = function() require('nvim-treesitter.install').update { with_sync = true } end,
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim', -- telescope
    requires = 'nvim-lua/plenary.nvim',
  }
  -- telescope extensions
  use 'nvim-telescope/telescope-file-browser.nvim' -- file browser
  use {
    'nvim-telescope/telescope-fzf-native.nvim', -- fuzzy find
    run = 'make',
  }

  -- LSP Zero
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },

      -- user (tigion) settings
      { 'onsails/lspkind-nvim' }, -- vscode-like pictograms
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' }, -- helper for mason to preinstall packages like 'shellsheck' which are not LSPs
    },
  }

  -- git
  use 'lewis6991/gitsigns.nvim'

  -- note / test
  --use 'glepnir/lspsaga.nvim' -- LSP UIs
  --use 'dinhhuy258/git.nvim' -- For git blame & browse
  -- use 'github/copilot.vim' -- ai code suggestions
  --use({
  --  "iamcco/markdown-preview.nvim",
  --  run = function() vim.fn["mkdp#util#install"]() end,
  --})

  -- fun
  use 'eandrju/cellular-automaton.nvim' -- :CellularAutomaton make_it_rain :CellularAutomaton game_of_life

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end

end)
