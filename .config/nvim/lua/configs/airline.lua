-- Configuration for vim-airline/vim-airline
vim.g.airline_left_sep = ''
vim.g.airline_powerline_fonts = 1
vim.g.airline_right_sep = ''
vim.g.airline_symbols = {
    branch = '⎇',
    linenr = '¶',
    paste = 'Þ',
    readonly = '🔒',
    whitespace = 'Ξ'
}
vim.g.airline_theme = 'zenburn'
vim.g['airline#extensions#branch#empty_message'] = ''
vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline#extensions#branch_prefix#enabled'] = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tmuxline#enabled'] = 0
