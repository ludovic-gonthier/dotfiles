local fn = vim.fn
local execute = vim.api.nvim_command

require('settings')

vim.api.nvim_exec(
[[
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

function DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        if getbufvar(buf, '&mod') == 0
            silent execute 'bwipeout' buf
        endif
    endfor
endfunction
nmap <silent> <leader>bo :call DeleteHiddenBuffers()<CR>
]], false)

require('mappings')

require('plugins')

require('colorscheme')

require('configs/filetree')
require('configs/syntax')

require('configs/airline')
require('configs/ale')
require('configs/devicons')
require('configs/fugitive')
require('configs/telescope')
require('configs/trouble')
require('configs/vimwiki')
require('lsp')
