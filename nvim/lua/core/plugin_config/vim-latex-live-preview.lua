--"Latex PDF previewer"
vim.g.livepreview_previewer = 'zathura'
vim.g.livepreview_use_biber = 1

vim.cmd "filetype plugin indent on"
vim.cmd "syntax enable"
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexrun'
vim.cmd "autocmd BufNewFile,BufRead *.tex set spelllang=es spell"
