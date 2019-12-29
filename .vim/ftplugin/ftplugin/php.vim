if exists("did_load_after_php")
  finish
endif
let did_load_after_php = 1

" Plugins
Plugin 'arnaud-lb/vim-php-namespace'
Plugin 'sniphpets/sniphpets'
Plugin 'sniphpets/sniphpets-common'
Plugin 'sniphpets/sniphpets-phpunit'
Plugin 'rayburgemeestre/phpfolding.vim'

" Plugins Configurations
let g:ale_linters = {
\   'php': ['php', 'php_cs_fixer'],
\}
let g:ale_fixers = {
\   'php': ['php_cs_fixer'],
\}

" PHP Namespace - Configuration
let g:php_namespace_sort_after_insert = 1

" VIM Polyglot - Configuration
let g:php_html_load = 0
let g:php_html_in_heredoc = 0
let g:php_html_in_nowdoc = 0
let g:php_sql_query = 0
let g:php_sql_heredoc = 0
let g:php_sql_nowdoc = 0


function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys("B i\\",  'i')
endfunction

augroup PHPNamespace
    autocmd FileType php noremap <Leader>pu :call PhpInsertUse()<CR>
    autocmd FileType php noremap <Leader>pe :call IPhpExpandClass()<CR>
augroup END

nmap <leader>rt :AsyncRun!  ctags -f .ctags<CR>
