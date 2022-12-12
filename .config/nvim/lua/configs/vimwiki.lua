-- Configuration for vimwiki/vimwiki
vim.g.vimwiki_list = {
  {path= '~/vimwiki/', syntax= 'markdown', ext= '.wiki'},
  {path= '~/playground/formation-yoga/', syntax= 'markdown', ext= '.md'}
}
vim.g.vimwiki_hl_headers = 1
vim.g.vimwiki_ext2syntax = {['.wiki']= 'markdown', ['.md'] = 'markdown'}
