set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'honza/vim-snippets'
Plugin 'jnurmine/zenburn'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
Plugin 'shougo/unite.vim'
Plugin 'shougo/vimproc.vim'
Plugin 'sirver/ultisnips'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'sniphpets/sniphpets'
Plugin 'sniphpets/sniphpets-common'
Plugin 'sniphpets/sniphpets-phpunit'
Plugin 'tpope/tpope-vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
Plugin 'junegunn/fzf'
Plugin 'suan/vim-instant-markdown'
Plugin 'jparise/vim-graphql'

call vundle#end()

filetype plugin indent on
if !has('g:syntax_on')
    syntax enable
endif


" VIM - Global configuration
set antialias
set autoindent
set autowrite                     " Automatically :write before running commands
set backspace=2
set backspace=indent,eol,start
set clipboard=unnamed             " For OSX clipboard
set completeopt+=preview
set cursorline                    " Highlight current line
set encoding=utf-8                " UTF-8 is the encoding you want for your files
set foldmethod=indent
set guifont=Hack\ 14              " Define hack as font, powerline
set hidden                        " Handle multiple buffers better.
set history=1000                  " Store lots of :cmdline history
set hlsearch                      " Highlight search results
set incsearch                     " Makes search act like in modern browsers
set laststatus=2                  " Always display the status line
set lazyredraw                    " Redraw only when we need to.
set list
set listchars=tab:▸\ ,eol:¬,trail:·,extends:>,precedes:<,nbsp:•
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
set tags+=.ctags/tags
set tabstop=4 " show existing tab with 4 spaces width
set ttyfast
set undodir=~/.vim/undofiles      " Do not add ~un files everywhere I go
set undofile                      " Persistent undo
set wildmenu                      " Enhanced command line completion.
set wildmode=longest,list,full    " Complete files like a shell.

let mapleader = ","
let maplocalleader = " "

" ZENBURN - Color theme
set t_Co=256
set background=dark

let g:zenburn_high_Contrast = 1
try
    colors zenburn
catch /^Vim\%((\a\+)\)\=:E185/
    " Should fail only at the first PluginInstall execution
endtry

" AIRLINE - Configuration
let g:airline_left_sep = ''
let g:airline_powerline_fonts=1
let g:airline_right_sep = ''
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.readonly = '🔒'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_theme='zenburn'
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch_prefix#enabled=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0


" ALE - Configuration
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'php': ['phpcs'],
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'php': ['phpcs'],
\}
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_lint_delay = 1000


" GITGUTTER - Configuration
let g:gitgutter_sign_added = '•'
let g:gitgutter_sign_modified = '•'
let g:gitgutter_sign_modified_removed = '•'
let g:gitgutter_sign_removed = '•'
let g:gitgutter_sign_removed_first_line = '•'


" NERDTREE - Configuration
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeHighlightFolders = 0
let g:NERDTreeHighlightFoldersFullName = 0
let g:NERDTreeSyntaxEnabledExtensions = ['css', 'js', 'jsx', 'twig', 'php', 'yaml', 'yml']
let g:NERDTreeIgnore = ['\.git$', '\.swp$', '\.swo$']
let g:NERDTreeShowHidden = 1

" VIM DEVICONS - Configuration
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let g:DevIconsEnableFoldersOpenClose = v:true
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['vendor'] = "\uf487"
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['node_modules'] = "\uf487"

" Omni completion configuration
let g:omni_syntax_group_include_php = 'php\w\+'
setlocal omnifunc=syntaxcomplete#Complete


" SNIPPETS - Configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"


" VIM Polyglot - Configuration
let g:php_html_load = 0
let g:php_html_in_heredoc = 0
let g:php_html_in_nowdoc = 0
let g:php_sql_query = 0
let g:php_sql_heredoc = 0
let g:php_sql_nowdoc = 0


" PHP Namespace - Configuration
let g:php_namespace_sort_after_insert = 1


" FZF
nnoremap <silent> <leader>f :FZF<CR>
nnoremap <silent> <leader>r :FZFA<CR>


" VIM - Custom functions
function! GetBufferList()
    redir =>buflist
    silent! ls!
    redir END
    return buflist
endfunction

function! ToggleList(bufname, pfx)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            exec(a:pfx.'close')
            return
        endif
    endfor
    if a:pfx == 'l' && len(getloclist(0)) == 0
        echohl ErrorMsg
        echo "Location List is Empty."
        return
    endif
    let winnr = winnr()
    exec(a:pfx.'open')
    if winnr() != winnr
        wincmd p
    endif
endfunction

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys("B i\\",  'i')
endfunction

" VIM - Global remap
" " Center window vertically on next/previous search match
noremap n nzz
noremap N Nzz
" " Y Have the same behaviour as D or C
noremap Y y$
" " Always open tag select when multiple tags available
noremap <C-]> g<C-]>

" VIM - Normal mode remap

" VIM - Visual mode remap
" " Sort selection
vnoremap <leader>s :sort u<cr>
vnoremap <leader>S :sort! u<cr>

" VIM - Normal mode map
nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> <leader>re :!tmux send-keys -t 1:1 C-p C-j <CR><CR>
nmap <leader>i magg=G'a
nmap <leader>rt :AsyncRun! ctags -f .ctags/tags --options=.ctags/.ctags<CR>
" " Fold/Unfold
nmap <leader><space> za
" " Window related mapping
" " Equalize splits
nmap <leader>= <C-w>=
" " Split horizontally
nmap <silent> <leader>- :split<CR>
" " Split vertically
nmap <silent> <leader>\| :vsplit<CR>
" " Toggle NERDTree
nmap <silent> <leader>e :NERDTreeToggle<CR><C-w>=
" " Find current file in NERDTree
nmap <silent> <leader>ef :NERDTreeFind<CR><C-w>=
" " Remove current buffer and go to the previous one
nmap <silent> <leader>bd :bp<CR>:bd#<CR>

" VIM - Custom commands
augroup PHPNamespace
    autocmd FileType php noremap <Leader>pu :call PhpInsertUse()<CR>
    autocmd FileType php noremap <Leader>pe :call IPhpExpandClass()<CR>
augroup END
augroup NERDTree
    " " Auto-start NERDTree if no file specify
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " " Do not set list in NERDTree
    autocmd FileType nerdtree setlocal nolist
augroup END

" Wrapper arround fzf, setup ag to not ignore files
:command! -nargs=0 FZFA
    \  execute ':let $FZF_DEFAULT_COMMAND_DEFAULT=$FZF_DEFAULT_COMMAND'
    \ | execute ':let $FZF_DEFAULT_COMMAND="ag -l -a --hidden"'
    \ | execute ':FZF'
    \ | execute ':let $FZF_DEFAULT_COMMAND=$FZF_DEFAULT_COMMAND_DEFAULT'

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif
