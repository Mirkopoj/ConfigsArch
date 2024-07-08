vim.api.nvim_create_autocmd("FileType", {
	pattern = {"rs", "rust"},
	callback = function ()
		vim.keymap.set("n", "J", ":RustLsp joinLines<CR>", {buffer = true})
	end
})
