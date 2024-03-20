if exists("did_load_json")
  finish
endif
let did_load_json = 1

nmap <leader>i :%!python -m json.tool<CR>
