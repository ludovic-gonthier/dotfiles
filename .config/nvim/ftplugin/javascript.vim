if exists("did_load_after_javascript")
  finish
endif
"" coc-jest
" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
nnoremap <leader>tp :call CocAction('runCommand', 'jest.projectTest')<CR>
" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
nnoremap <leader>tf :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>
" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
" Init jest in current cwd, require global jest command exists
command! JestInit :call CocAction('runCommand', 'jest.init')

let did_load_after_javascript = 1
