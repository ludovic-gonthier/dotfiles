vim.cmd 'syntax enable'
vim.cmd 'filetype plugin indent on'

-- nvim-tree: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local o = vim.o     -- Global options
o.autowrite = false
o.backspace = 'indent,eol,start'
o.background = 'dark'
o.clipboard = 'unnamed'
o.cmdheight = 2
o.completeopt = 'menu,preview'
o.encoding = 'utf-8'
o.editorconfig = true
o.guifont = 'Hack 14'
o.hidden = true
o.history = 1000
o.hlsearch = true
o.incsearch = true
o.laststatus = 2
o.lazyredraw = true
o.mouse = nil
o.number = true
o.path = '.,/usr/include,,**,'
o.ruler = true
o.shell = 'zsh'
o.shortmess = 'filnxtToOFc'
o.showcmd = true
o.showmatch = true
o.showmode = true
o.tags = './tags;,tags;,.ctags'
o.undodir = vim.fn.expand('~')..'/.config/nvim/undofiles'
o.wildmenu = true
o.wildmode = 'longest,list,full'
o.termguicolors = true

local wo = vim.wo   -- Window options
wo.cursorline = true
wo.foldmethod = 'syntax'
wo.list = true
wo.relativenumber = true
wo.signcolumn = 'yes'

local bo = vim.bo   -- Buffer options
bo.autoindent = true
bo.shiftwidth = 4
bo.tabstop = 4
bo.undofile = true
bo.omnifunc = 'syntaxcomplete#Complete'

vim.g.omni_syntax_group_include_php = 'php\\w\\+'

vim.opt.listchars = { eol = '¬', extends = '>', nbsp = '•', precedes = '<', tab = '▸ ', trail = '·' }
vim.opt.diffopt = vim.opt.diffopt + 'linematch:50'

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.json",
    command = "set filetype=json"
})
