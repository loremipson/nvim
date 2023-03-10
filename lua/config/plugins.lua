local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn" },
		symbols = { error = " ", warn = " " },
		colored = true,
		always_visible = false,
}

local diff = {
		"diff",
		colored = true,
		symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
}

local filetype = {
		"filetype",
		icons_enabled = false,
}

local location = {
		"location",
		padding = 0,
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
		-- NOTE: First, some plugins that don't require any configuration

		-- NOTE: This is where your plugins related to LSP can be installed.
		--  The configuration is done below. Search for lspconfig to find it below.
		{ -- LSP Configuration & Plugins
				'neovim/nvim-lspconfig',
				dependencies = {
						-- Automatically install LSPs to stdpath for neovim
						'williamboman/mason.nvim',
						'williamboman/mason-lspconfig.nvim',

						-- Useful status updates for LSP
						-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
						{ 'j-hui/fidget.nvim', opts = {} },

						-- Additional lua configuration, makes nvim stuff amazing!
						'folke/neodev.nvim',
				},
		},

		-- Tree
		{
				"nvim-tree/nvim-tree.lua",
				keys = {
						{ "-", "<cmd>lua require'nvim-tree'.toggle()<CR>", desc = "NvimTree" },
				},
				config = function()
					require("plugins.tree")
				end,
		},

		-- Autocompletion
		{
				'hrsh7th/nvim-cmp',
				dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
				config = function()
					require('plugins.cmp')
				end
		},

		-- scrollbar
		{
				'petertriho/nvim-scrollbar',
				opts = {}
		},

		-- Useful plugin to show you pending keybinds.
		{ 'folke/which-key.nvim',   opts = {} },

		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		{
				'lewis6991/gitsigns.nvim',
				config = function()
					require('gitsigns').setup()
					require('scrollbar.handlers.gitsigns').setup()
				end,
				opts = {
						-- See `:help gitsigns.txt`
						signs = {
								add = { text = '+' },
								change = { text = '~' },
								delete = { text = '_' },
								topdelete = { text = '‾' },
								changedelete = { text = '~' },
						},
				},
		},

		{ "kylechui/nvim-surround", lazy = false, config = true },

		{
				'alexghergh/nvim-tmux-navigation', config = function()
			require('nvim-tmux-navigation').setup({
					keybindings = {
							left = "<C-h>",
							down = "<C-j>",
							up = "<C-k>",
							right = "<C-l>",
							last_active = "<C-\\>",
							next = "<C-Space>",
					}
			})
		end
		},

		{
				'folke/tokyonight.nvim',
				priority = 1000,
				config = function()
					vim.cmd.colorscheme 'tokyonight-night'
				end,
		},

		-- Set lualine as statusline
		{
				'nvim-lualine/lualine.nvim',
				-- See `:help lualine.txt`
				opts = {
						options = {
								icons_enabled = false,
								theme = 'tokyonight',
								component_separators = '|',
								section_separators = '',
						},
						sections = {
								lualine_a = { "mode" },
								lualine_b = { "branch" },
								lualine_c = { diagnostics },
								lualine_x = { diff, spaces, "encoding", filetype },
								lualine_y = { location },
								lualine_z = { "progress" },
						},
				},
		},

		{ -- Add indentation guides even on blank lines
				'lukas-reineke/indent-blankline.nvim',
				-- Enable `lukas-reineke/indent-blankline.nvim`
				-- See `:help indent_blankline.txt`
				opts = {
						char = '┊',
						show_trailing_blankline_indent = false,
				},
		},

		-- "gc" to comment visual regions/lines
		{ 'numToStr/Comment.nvim', opts = {} },

		-- git
		{
				"kdheepak/lazygit.nvim",
				cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitFilterCurrentFile", "LazyGitFilter" },
				config = function()
					vim.g.lazygit_floating_window_scaling_factor = 1
				end,
		},
		-- github integration
		{
				'pwntester/octo.nvim',
				requires = {
						'nvim-lua/plenary.nvim',
						'nvim-telescope/telescope.nvim',
						'kyazdani42/nvim-web-devicons',
				},
				config = function()
					require("octo").setup()
				end
		},

		-- Fuzzy Finder (files, lsp, etc)
		{
				'nvim-telescope/telescope.nvim',
				version = '*',
				lazy = false,
				config = function()
					require("plugins.telescope")
				end,
				dependencies = { 'nvim-lua/plenary.nvim' }
		},

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
		},

		{
				"axelvc/template-string.nvim",
				event = "InsertEnter",
				ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				config = true, -- run require("template-string").setup()
		},

		{ -- Highlight, edit, and navigate code
				'nvim-treesitter/nvim-treesitter',
				dependencies = {
						'nvim-treesitter/nvim-treesitter-textobjects',
				},
				config = function()
					require('plugins.treesitter')
					-- pcall(require('nvim-treesitter.install').update { with_sync = true })
				end,
		},

		-- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
		--       These are some example plugins that I've included in the kickstart repository.
		--       Uncomment any of the lines below to enable them.
		require 'kickstart.plugins.autoformat',
		-- require 'kickstart.plugins.debug',
}, {})
