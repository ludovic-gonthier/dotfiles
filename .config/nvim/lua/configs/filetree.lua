require("nvim-tree").setup({
    open_on_setup = true,
    filters = {
        exclude = {
            'vendor',
            'node_modules',
        },
    },
    -- actions = {
    --     open_file = {
    --         window_picker = {
    --             enable = false,
    --         },
    --     },
    -- },
})

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>', { silent = true })
