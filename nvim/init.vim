:set number
:set relativenumber
:set autoindent
:set tabstop=3
:set shiftwidth=3
:set smarttab
:set softtabstop=3
:set mouse=a

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/mg979/vim-visual-multi' " CTRL + N for multiple cursors
Plug 'https://github.com/nvim-treesitter/nvim-treesitter',{'do': 'TSUpdate'} "Sintax highlighting
Plug 'https://github.com/kevinhwang91/rnvimr',{'do': 'make sync'} "Ranger
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'lervag/vimtex'
Plug 'stevearc/vim-arduino'

call plug#end()

"Magia Macro
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"Custom commands
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev wQ wq
cnoreabbrev qW wq
cnoreabbrev qw wq
cnoreabbrev QW wq
cnoreabbrev Qw wq
cnoreabbrev Q q
" Save file with sudo
:command -nargs=0  WriteWithSudo w !sudo tee % >/dev/null
" Use :ww instead of :WriteWithSudo
cnoreabbrev ww WriteWithSudo

"Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1
nmap <space>r :RnvimrToggle<CR>
hi link NormalFloat NONE

"Latex PDF previewer"
let g:livepreview_previewer = 'zathura'
let g:livepreview_use_biber = 1

filetype plugin indent on
syntax enable
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'latexrun'
autocmd BufNewFile,BufRead *.tex set spelllang=es spell

"Auto Completion"
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

"Coc setups
	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window.
	nnoremap <silent> K :call ShowDocumentation()<CR>

	function! ShowDocumentation()
	  if CocAction('hasProvider', 'hover')
		 call CocActionAsync('doHover')
	  else
		 call feedkeys('K', 'in')
	  endif
	endfunction

	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)

	" Formatting selected code.
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocActionAsync('format')

	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

	hi CocMenuSel ctermbg=237 guibg=#4A134A "#13354A

"Vim Splits"
"move"
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"Resize"
nnoremap <C-S-l> :vertical resize +3<CR>
nnoremap <C-S-h> :vertical resize -3<CR>
nnoremap <C-S-k> :resize +3<CR>
nnoremap <C-S-j> :resize -3<CR>

"Arduino + airline
function! ArduinoStatusLine()
  let port = arduino#GetPort()
  let line = '[' . g:arduino_board . '] [' . g:arduino_programmer . ']'
  if !empty(port)
    let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
  endif
  return line
endfunction
autocmd BufNewFile,BufRead *.ino let g:airline_section_x='%{ArduinoStatusLine()}'

lua << luant
require'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
	 disable = { "latex" },
    additional_vim_regex_highlighting = false,
  },
}
luant
