vim.cmd([[
	let g:codi#interpreters = {
		\ 'python': {
			\ 'bin': 'python',
			\ 'prompt': '^\(>>>\|\.\.\.\) ',
			\ },
		\ }
]])

vim.cmd([[
	let g:ripple_enable_mappings = 1
	let g:ripple_always_return = 1
	let g:ripple_repls = {}
	let g:ripple_repls["python"] = {
		 \ "command": "ipython",
		 \ "pre": "\<esc>[200~",
		 \ "post": "\<esc>[201~",
		 \ "addcr": 0,
		 \ "filter": 0,
		 \ }
]])
