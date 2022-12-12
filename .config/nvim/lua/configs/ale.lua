-- Configuration for dense-analysis/ale
vim.g.ale_linters = {
   ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
   javascript = {'eslint'},
   scss = {'stylelint'},
}
vim.g.ale_fixers = {
   javascript = {'prettier'},
   scss = {'stylelint'},
}
vim.g.ale_fix_on_save = 1
vim.g.ale_sign_error = '✗'
vim.g.ale_sign_warning = '⚠'
vim.g.ale_lint_delay = 1000
