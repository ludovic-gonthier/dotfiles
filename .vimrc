set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/taglist.vim'
Plugin 'w0ng/vim-hybrid'

call vundle#end()
filetype plugin indent on

set background=dark
colorscheme hybrid 

set t_Co=256
set autowrite                     " Automatically :write before running commands
set clipboard=unnamed             " For OSX clipboard
set encoding=utf-8                " UTF-8 is the encoding you want for your files
set foldmethod=indent
set hidden                        " Handle multiple buffers better.
set history=1000                  " Store lots of :cmdline history
set hlsearch                      " Highlight search results
set incsearch                     " Makes search act like in modern browsers
set lazyredraw                    " Redraw only when we need to.
set laststatus=2                  " Always display the status line
set novisualbell                  "
set noerrorbells                  " No error bells
set showmode                      " Show mode -- INSERT --
set showcmd                       " Show commands
set showmatch                     " Highlight matching [{()}]
set ttyfast
set undofile                      " Persistent undo
set undodir=~/.vim/undofiles      " Do not add ~un files everywhere I go
set wildmode=list:longest         " Complete files like a shell.
set wildmenu                      " Enhanced command line completion.
syntax enable

set antialias
set background=dark               " Dark bg
set guifont=Hack:h14              " Define hack as font, powerline
set cursorline                    " Highlight current line
set ruler                         " Display ruler
set relativenumber                " Set relative number for fast dd/yy
set number

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


" Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0

" set airline theme
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch_prefix#enabled=1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#syntastic#enabled=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.whitespace = 'Ξ'
  let g:airline_symbols.readonly = '🔒'

set laststatus=2
set listchars=tab:▸\ ,eol:¬,trail:·,extends:>,precedes:<

" Syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntax Checker
let g:syntastic_php_checkers = ['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_json_checkers = ['jsonlint']

" Better syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python let b:comment_leader = '# '
autocmd FileType conf,fstab let b:comment_leader = '# '
autocmd FileType tex let b:comment_leader = '% '
autocmd FileType mail let b:comment_leader = '> '
autocmd FileType vim let b:comment_leader = '" '
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Key Bindings
:vnoremap <F9> :sort u<cr>
" Toggle folding
:nnoremap <space> za

