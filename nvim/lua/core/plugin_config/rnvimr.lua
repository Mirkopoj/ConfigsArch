--Make Ranger replace netrw and be the file explorer
vim.api.nvim_set_keymap('n', '<leader>t', ":RnvimrToggle<CR>", { noremap = true, silent = true });
vim.cmd "hi link NormalFloat NONE"
vim.g.rnvimr_ex_enable = 1
