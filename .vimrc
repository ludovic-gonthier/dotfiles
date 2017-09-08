set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'evidens/vim-twig' 
Plugin 'jnurmine/Zenburn'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'othree/yajs.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sheerun/vim-polyglot'
Plugin 'suan/vim-instant-markdown'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'tpope/tpope-vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'


" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'sniphpets/sniphpets'
Plugin 'sniphpets/sniphpets-common'
Plugin 'sniphpets/sniphpets-phpunit'

call vundle#end()

filetype plugin indent on

syntax enable

" Color theme
set t_Co=256
set background=dark

let g:zenburn_high_Contrast = 1

colors zenburn 

" Global configuration
set antialias
set autowrite                     " Automatically :write before running commands
set backspace=2
set backspace=indent,eol,start
set clipboard=unnamed             " For OSX clipboard
set cursorline                    " Highlight current line
set encoding=utf-8                " UTF-8 is the encoding you want for your files
set foldmethod=indent
set guifont=Hack\ 14              " Define hack as font, powerline
set hidden                        " Handle multiple buffers better.
set history=1000                  " Store lots of :cmdline history
set hlsearch                      " Highlight search results
set incsearch                     " Makes search act like in modern browsers
set laststatus=2
set laststatus=2                  " Always display the status line
set lazyredraw                    " Redraw only when we need to.
set listchars=tab:▸\ ,eol:¬,trail:·,extends:>,precedes:<
set noerrorbells                  " No error bells
set novisualbell                  "
set number
set path+=**
set relativenumber                " Set relative number for fast dd/yy
set ruler                         " Display ruler
set shell=zsh
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set showcmd                       " Show commands
set showmatch                     " Highlight matching [{()}]
set showmode                      " Show mode -- INSERT --
set tabstop=4 " show existing tab with 4 spaces width
set ttyfast
set undodir=~/.vim/undofiles      " Do not add ~un files everywhere I go
set undofile                      " Persistent undo
set wildmenu                      " Enhanced command line completion.
set wildmode=longest,list,full    " Complete files like a shell.

" Omni completion configuration
setlocal omnifunc=syntaxcomplete#Complete
let g:omni_syntax_group_include_php = 'php\w\+'

" Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0

" set airline theme
let g:airline_theme='zenburn'
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

" Syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{fugitive#statusline()}
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
let g:syntastic_javascript_checkers = ['eslint', 'npm run lint']
let g:syntastic_json_checkers = ['jsonlint']

let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" Better syntastic symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Snippets configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" NERDTres configuration
let g:NERDTreeShowHidden = 1 " Show hidden files
let g:NERDTreeAutoDeleteBuffer = 1 " auto delete the buffer of the file you just deleted with NERDTree
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 0 " highlights the folder name
let g:NERDTreeIgnore = ['\.git$', '\.swp$', '\.swo$']

" Auto-start NERDTree if no file specify
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" vim-devicons configuration
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0

" Higlight non-breaking spaces
au VimEnter,BufWinEnter * syn match ErrorMsg " "

" Key Bindings
:vnoremap <F9> :sort u<cr>

" Toggle folding
:nnoremap <space> za 

" Custom commands

" Silently execute a function
command! -nargs=+ Silent execute 'silent <args>' | redraw!

" Refresh in background the ctags list
command! RefreshTag execute ":Silent !ctags -R . > /dev/null 2>&1 &"
