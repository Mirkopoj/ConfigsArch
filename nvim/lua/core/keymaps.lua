vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.smarttab = true
vim.opt.softtabstop = 3
vim.opt.mouse = 'a'

--Tipos
vim.cmd([[
	cnoreabbrev W w
	cnoreabbrev Wq wq
	cnoreabbrev WQ wq
	cnoreabbrev wQ wq
	cnoreabbrev qW wq
	cnoreabbrev qw wq
	cnoreabbrev QW wq
	cnoreabbrev Qw wq
	cnoreabbrev Q q
]])

--Splits
--move
vim.api.nvim_set_keymap('n', '<C-h>', "<C-w>h", { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<C-j>', "<C-w>j", { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<C-k>', "<C-w>k", { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<C-l>', "<C-w>l", { noremap = true, silent = true });
--Resize
vim.api.nvim_set_keymap('n', '<C-S-l> :vertical resize', "+3<CR>", { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<C-S-h> :vertical resize', "-3<CR>", { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<C-S-k> :resize', "+3<CR>", { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<C-S-j> :resize', "-3<CR>", { noremap = true, silent = true });
