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
local function is_rightmost_window()
	local cur_win = vim.api.nvim_get_current_win()
	local layout = vim.fn.winlayout()

	local function traverse_layout(node)
		if node[1] == "leaf" then
			return { node[2] }
		elseif node[1] == "row" then
			return traverse_layout(node[2][#node[2]])
		elseif node[1] == "col" then
			local rightmost_windows = {}
			for _, col_node in ipairs(node[2]) do
				local col_windows = traverse_layout(col_node)
				for _, win in ipairs(col_windows) do
					table.insert(rightmost_windows, win)
				end
			end
			return rightmost_windows
		end
		return {}
	end

	local rightmost_windows = traverse_layout(layout)

	for _, win in ipairs(rightmost_windows) do
		if win == cur_win then
			return true
		end
	end
	return false
end

function Resize_left()
	if is_rightmost_window() then
		vim.cmd('vertical resize +3')
	else
		vim.cmd('vertical resize -3')
	end
end

function Resize_right()
	if is_rightmost_window() then
		vim.cmd('vertical resize -3')
	else
		vim.cmd('vertical resize +3')
	end
end

vim.api.nvim_set_keymap('n', '<C-S-h>', ':lua Resize_left()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-S-l>', ':lua Resize_right()<CR>', { noremap = true, silent = true })

local function is_downmost_window()
	local cur_win = vim.api.nvim_get_current_win()
	local layout = vim.fn.winlayout()

	local function traverse_layout(node)
		if node[1] == "leaf" then
			return { node[2] }
		elseif node[1] == "col" then
			return traverse_layout(node[2][#node[2]])
		elseif node[1] == "row" then
			local downmost_windows = {}
			for _, col_node in ipairs(node[2]) do
				local col_windows = traverse_layout(col_node)
				for _, win in ipairs(col_windows) do
					table.insert(downmost_windows, win)
				end
			end
			return downmost_windows
		end
		return {}
	end

	local downmost_windows = traverse_layout(layout)

	for _, win in ipairs(downmost_windows) do
		if win == cur_win then
			return true
		end
	end
	return false
end

function Resize_up()
	if is_downmost_window() then
		vim.cmd('resize +3')
	else
		vim.cmd('resize -3')
	end
end

function Resize_down()
	if is_downmost_window() then
		vim.cmd('resize -3')
	else
		vim.cmd('resize +3')
	end
end

vim.api.nvim_set_keymap('n', '<C-S-k>', ':lua Resize_up()<CR>', { noremap = true, silent = true });
vim.api.nvim_set_keymap('n', '<C-S-j>', ':lua Resize_down()<CR>', { noremap = true, silent = true });

--term
vim.api.nvim_set_keymap('t', '<Esc>', "<C-\\><C-n>", { noremap = true, silent = true });
