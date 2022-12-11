if exists("did_load_filetypes")
	finish
endif
augroup filetypedetect
	au! BufRead,BufNewFile *.comp       setfiletype glsl
	au! BufRead,BufNewFile *.vert       setfiletype glsl
	au! BufRead,BufNewFile *.frag       setfiletype glsl
augroup END
