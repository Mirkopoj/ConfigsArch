require("dapui").setup()
require("mason-nvim-dap").setup({
    automatic_setup = true,
})
require 'mason-nvim-dap'.setup_handlers {}

vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F6>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F7>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F8>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>db", ":lua require'dapui'.toggle()<CR>")

local dap = require('dap')
dap.configurations.cpp[1]["args"] = function ()
	local t = {}
	local str = vim.fn.input('Arguments: ')
	local _ = str:gsub("[^%s]+",function(c) table.insert(t,c) end)
	return t
end

dap.configurations.python[1]["pythonPath"] = '/usr/bin/python'
