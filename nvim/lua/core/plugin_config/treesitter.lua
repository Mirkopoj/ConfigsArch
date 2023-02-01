require'nvim-treesitter.configs'.setup {
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
	 disable = { "latex" },
    additional_vim_regex_highlighting = false,
  },
}
