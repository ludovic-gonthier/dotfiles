-- VIM - Global remap
local set = vim.keymap.set
local opts = {remap = false}

vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Center window vertically on next/previous search match
set('n', 'n', 'nzz', {remap = false})
set('n', 'N', 'Nzz', {remap = false})

-- Y Have the same behaviour as D or C
set('n', 'Y', 'Y$', {remap = false})

-- Always open tag select when multiple tags available
set('n', '<C-]>', 'g<C-]>', {remap = false})

-- VIM - Visual mode remap

-- Sort selection
set('v', '<leader>s', ':sort u<cr>', {remap = false})
set('v', '<leader>S', ':sort! u<cr>', {remap = false})

-- local M = {}

-- M.toggle_list = function(list)
--   local qf_exists = false
--   for _, win in pairs(vim.fn.getwininfo()) do
--     if win[list] == 1 then
--       qf_exists = true
--     end
--   end

--   if qf_exists == true then
--     if list == 'quickfix' then
--         vim.cmd 'ccl'
--     else
--         vim.cmd 'lcl'
--     end

--     return
--   end

--     if list == 'quickfix' then
--         vim.cmd "copen"
--     else
--         local of, error = pcall( vim.cmd, 'lopen')
--     end
-- end

-- VIM - Normal mode map
-- Toggle location list
-- set('n', '<leader>l', function () M.toggle_list('loclist') end, {silent = true})
-- Toggle quickfix list
-- set('n', '<leader>q', function () M.toggle_list('quickfix') end, {silent = true})
-- Replay a TMUX command
set('n', '<leader>re', ':!tmux send-keys -t 1:1 C-p C-j <CR><CR>', {silent = true})
-- Indent all file
set('n', '<leader>i', "magg=G'a")

-- Fold/Unfold
set('n', '<leader> ', 'za')
-- Window related mapping
-- Equalize splits
set('n', '<leader>=', '<C-w>=')
-- Split horizontally
set('n', '<leader>-', ':split<CR>')
-- Split vertically
set('n', '<leader>|', ':vsplit<CR>')
-- Toggle NERDTree
set('n', '<leader>e', ':NERDTreeToggle<CR><C-w>=', {silent = true})
-- Find current file in NERDTree
set('n', '<leader>ef', ':NERDTreeFind<CR><C-w>=', {silent = true})
-- Remove current buffer and go to the previous one
set('n', '<leader>bd', ':bp<CR>:bd#<CR>', {silent = true})
--nmap <silent> <leader>bo :call DeleteHiddenBuffers()<CR>

-- Compute the php-ctags
set('n', '<leader>rt', ':AsyncRun! ctags -f .ctags --options=$HOME/.config/php.config.ctags<CR>')
