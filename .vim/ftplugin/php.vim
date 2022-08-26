if exists("did_load_after_php")
  finish
endif
let did_load_after_php = 1

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

" "
" "phplang": {
"     "rootPatterns": ["composer.json"],
"     "command": "php",
"     "args": ["/home/ludovic-gonthier/src/php-language-server/bin/php-language-server.php"],
"     "filetypes": ["php"]
" }

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys("B i\\",  'i')
endfunction

augroup PHPNamespace
    autocmd FileType php noremap <Leader>pu :call PhpInsertUse()<CR>
    autocmd FileType php noremap <Leader>pe :call IPhpExpandClass()<CR>
augroup END

augroup PHP
    autocmd!
    autocmd FileType php setlocal iskeyword-=$
augroup END
