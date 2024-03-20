if exists("did_load_after_sh")
  finish
endif

let did_load_after_sh = 1

let b:ale_linters = ['shellcheck']
" let b:ale_fixers = ['shfmt']
let b:ale_sh_shfmt_options = '-i 2 -ci'