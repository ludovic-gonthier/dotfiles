if exists("did_load_cpp")
  finish
endif
let did_load_cpp = 1

" Plugins Configurations
let g:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': [],
\}
let g:ale_fixers = {
\   'cpp': ['clang-format'],
\}

let s:cpp_build_dir = 'build'
let s:cpp_sources_dir = 'application'
let g:ale_c_clangformat_executable = '/home/ludovic-gonthier/src/llvm-project/build-llvm/bin/clang-format'
"
"    "languageserver": {
"        "clangd": {
"            "trace.server": "verbose",
"            "args": ,
"            "command": "/usr/bin/clangd",
"            "filetypes": ["c", "cpp", "objc", "objcpp"]
"        }
"    },

" VIM Inspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
sign define vimspectorBP text=🔴 texthl=Normal
sign define vimspectorBPDisabled text=🔵 texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad

function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction

nmap <localleader>t :call SwitchSourceHeader()<CR>

nmap <leader>b :make! build<CR>
nmap <leader>c :make! clean<CR>
nmap <leader>x :make! run<CR>
nmap <leader>t :!make test<CR>

" Vimspector mapping
nmap <localleader>c <Plug>VimspectorContinue
nmap <localleader>s <Plug>VimspectorStop
nmap <localleader>r <Plug>VimspectorRestart
nmap <localleader>p <Plug>VimspectorPause
nmap <localleader>b <Plug>VimspectorToggleBreakpoint
nmap <localleader>lb <Plug>VimspectorAddFunctionBreakpoint
nmap <localleader>o <Plug>VimspectorStepOver
nmap <localleader>i <Plug>VimspectorStepInto
nmap <localleader>u <Plug>VimspectorStepOut
