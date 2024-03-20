-- Configuration for tpope/vim-fugitive
vim.g.fugitive_pty = 0

-- Open fugitive Gstatus in new tab with Glog
vim.keymap.set('n', '<leader>G', ':G<bar> wincmd T <bar> vsplit <bar> wincmd l <bar>+:Gclog ...origin/master<CR>')