if exists("did_load_after_javascript")
  finish
endif
let did_load_after_javascript = 1

nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient#textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient#textDocument_hover()<cr>
