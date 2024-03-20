-- Configuration of nvim-telescope/telescope.nvim
local opts = {remap = false}
local set = vim.keymap.set

set('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files()<cr>", opts)
set('n', '<leader>fg', "<cmd>lua require'telescope.builtin'.live_grep()<cr>", opts)
set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- A single -u won't respect .gitignore files
table.insert(vimgrep_arguments, "-u")
table.insert(vimgrep_arguments, "-L")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

require('telescope').setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
        mappings = {
            i = {
                ["<C-t>"] = require("trouble.providers.telescope").smart_open_with_trouble,
                ["<C-q>"] = require('telescope.actions').smart_send_to_qflist,
            },
            n = {
                t = require("trouble.providers.telescope").smart_open_with_trouble,
                q = require('telescope.actions').smart_send_to_qflist,
            },
        },
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "-u", "-L", "--glob", "!.git/*" },
            mappings = {
                i = {
                    ['<C-j>'] = {
                        require('telescope.actions').move_selection_next,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                    ['<C-k>'] = {
                        require('telescope.actions').move_selection_previous,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                },
            },
		},
        live_grep = {
            mappings = {
                i = {
                    ['<C-j>'] = {
                        require('telescope.actions').move_selection_next,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                    ['<C-k>'] = {
                        require('telescope.actions').move_selection_previous,
                        type = "action",
                        opts = { nowait = true, silent = true },
                    },
                },
            },
		},
	},
})
require('telescope').load_extension("emoji")
