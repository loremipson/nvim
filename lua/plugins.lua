local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    'rose-pine/neovim',
    config = function()
      require('plugin-configs.rose-pine').setup()
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-live-grep-args.nvim', version = '^1.0.0' },
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('plugin-configs.telescope').setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
    },
    config = function()
      require('plugin-configs.treesitter').setup()
    end,
  },
  {
    'williamboman/mason.nvim',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      require('plugin-configs.mason').setup()
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      { 'antosha417/nvim-lsp-file-operations', config = true },
    },
    config = function()
      require('plugin-configs.nvim-lspconfig').setup()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
    },
    config = function()
      require('plugin-configs.nvim-cmp').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {}
    end,
  },
  {
    'numToStr/Navigator.nvim',
    config = function()
      require('plugin-configs.navigator').setup()
    end,
  },
  {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugin-configs.conform').setup()
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('plugin-configs.nvim-lint').setup()
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('plugin-configs.lazygit').setup()
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugin-configs.git-signs').setup()
    end,
  },
  { 'folke/todo-comments.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('plugin-configs.noice').setup()
    end,
  },
  {
    'folke/trouble.nvim',
    config = function()
      require('plugin-configs.trouble').setup()
    end,
  },
  {
    'kndndrj/nvim-dbee',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require('dbee').install()
    end,
    config = function()
      require('dbee').setup(--[[optional config]])
    end,
  },
}

require('lazy').setup(plugins)
