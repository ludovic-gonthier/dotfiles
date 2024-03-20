vim.o.termguicolors = true

require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = true,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    styles = {               -- Style to be applied to different syntax groups
      comments = "italic,underline",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "bold",
      functions = "bold",
      keywords = "bold",
      numbers = "NONE",
      operators = "NONE",
      strings = "italic",
      types = "bold,italic",
      variables = "NONE",
    },
  },
})

vim.cmd 'colorscheme nightfox'
