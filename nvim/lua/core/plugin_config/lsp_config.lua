require("mason").setup()
require("mason-lspconfig").setup()
require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

local on_attach = function(_, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

	vim.keymap.set('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)

	vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>',
		{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>',
		{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>',
		{ noremap = true, silent = true })
	vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

local servers = {
	'lua_ls',
	'pylsp',
	'arduino_language_server',
	'clangd',
	'julials',
	'taplo',
	'vimls',
	'asm_lsp',
	'html',
	'cssls',
	'tsserver',
	'bashls',
	'zls',
	'hls',
}

--[[
if not lspconfig.glslls then
	lspconfig.glslls = {
		default_config = {
			cmd = { '/usr/local/bin/glslls', '--stdin' },
			filetypes = { 'glsl', 'fs', 'vs' },
			root_dir = function(fname)
				return lspconfig.util.find_git_ancestor(fname)
			end,
			settings = {},
		},
	}
end
]]

lspconfig.ltex.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		ltex = {
			language = "es-AR",
		},
	},
}

--[[
lspconfig.rust_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			checkOnSave = {
				allFeatures = true,
				command = "clippy",
				extraArgs = {
					"--",
					"--no-deps",
					"-Dclippy::correctness",
					"-Dclippy::complexity",
					"-Wclippy::perf",
					"-Wclippy::pedantic",
				},
			}
		}
	}
}
]]

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

require('flutter-tools').setup { settings = {
	lsp = {
		on_attach = on_attach,
	}
}
}

vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {
	},
	-- LSP configuration
	server = {
		on_attach = on_attach,
			-- you can also put keymaps in here
		default_settings = {
			-- rust-analyzer language server configuration
			['rust-analyzer'] = {
				cargo = {
					allFeatures = true,
					loadOutDirsFromCheck = true,
					runBuildScripts = true,
				},
				checkOnSave = {
					allFeatures = true,
					command = "clippy",
					extraArgs = {
						"--",
						"--no-deps",
						"-Dclippy::correctness",
						"-Dclippy::complexity",
						"-Wclippy::perf",
						"-Wclippy::pedantic",
					},
				}
			},
		},
	},
	-- DAP configuration
	dap = {
	},
}
