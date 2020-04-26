if exists("did_load_after_orgmode")
  finish
endif
let did_load_after_orgmode = 1

let g:utl_cfg_hdl_mt_generic = 1
let g:utl_cfg_hdl_scm_http_system = "silent !google-chrome '%u#%f' &"
let g:org_agenda_files=['~/org/index.org']
