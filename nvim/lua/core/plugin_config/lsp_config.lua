require("mason").setup()
require("mason-lspconfig").setup()

local on_attach = function(_, bufnr)
	 local bufopts = { noremap=true, silent=true, buffer=bufnr }

	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})

	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

local servers = {
	'sumneko_lua',
	'pyright',
	'rust_analyzer',
	'arduino_language_server',
	'clangd',
	'julials',
	'ltex',
	'taplo',
	'vimls',
	'glslls'
}

if not lspconfig.glslls then
    lspconfig.glslls = {
        default_config = {
            cmd = {'/usr/local/bin/glslls', '--stdin'};
            filetypes = {'glsl', 'fs', 'vs'};
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end;
            settings = {},
            },
        }
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
