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

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'Mirkopoj/nvim-colors'
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use 'ryanoasis/vim-devicons'        -- Developer Icons
	use 'mg979/vim-visual-multi'        -- CTRL + N for multiple cursors
	use 'nvim-treesitter/nvim-treesitter' --Sintax highlighting
	use 'kevinhwang91/rnvimr'           --Ranger
	use 'xuhdev/vim-latex-live-preview'
	use 'stevearc/vim-arduino'
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		requires = { { 'nvim-lua/plenary.nvim',
			'debugloop/telescope-undo.nvim'
		} }
	}
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'

	use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
	}

	use 'norcalli/nvim-colorizer.lua'
	use 'Mirkopoj/vim-pio'
	use 'Mirkopoj/mplabx-nvim-lspCompat'
	use 'Mirkopoj/mplabx-nvim-autoloadfiles'

	use "folke/neodev.nvim"
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
	use "jay-babu/mason-nvim-dap.nvim"

	use 'metakirby5/codi.vim'
	use 'urbainvaes/vim-ripple'

	use {
		'akinsho/flutter-tools.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
	}

	use 'tpope/vim-fugitive'

	use 'da-h/AirLatex.vim'

	use {
		'nvim-neotest/neotest',
		requires = {
			'nvim-neotest/nvim-nio',
			'nvim-lua/plenary.nvim',
			'antoinemadec/FixCursorHold.nvim',
			'nvim-treesitter/nvim-treesitter',
		}
	}

	use 'mrcjkb/rustaceanvim'

	if packer_bootstrap then
		require('packer').sync()
	end
end)
