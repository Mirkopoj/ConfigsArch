require('neotest').setup {
	adapters = {
		require('rustaceanvim.neotest')
	}
}

require('neodev').setup {
	library = { plugins = { "neotest" }, types = true },
}

vim.keymap.set("n", "<leader>ch", "<cmd>lua require('neotest').run.run()<CR>")
vim.keymap.set("n", "<leader>cs", "<cmd>lua require('neotest').summary.toggle()<CR>")
vim.keymap.set("n", "<leader>co", "<cmd>lua require('neotest').output.open()<CR>")
vim.keymap.set("n", "<leader>cw", "<cmd>lua require('neotest').watch.watch()<CR>")
