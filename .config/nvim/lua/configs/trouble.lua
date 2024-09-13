vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<cr>",
    {silent = true, noremap = true}
)

require('trouble').setup({
    auto_close = true,
    modes = {
        preview_float = {
            mode = "diagnostics",
            preview = {
                type = "float",
                relative = "editor",
                border = "rounded",
                title = "Preview",
                title_pos = "center",
                position = { 0, -2 },
                size = { width = 0.3, height = 0.3 },
                zindex = 200,
            },
        },
    },
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "",

    },
})