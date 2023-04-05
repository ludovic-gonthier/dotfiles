
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { 'html', 'jsonls', 'tsserver' }
})

require('lsp_signature').setup({
  bind = true,
  hint_enable = false,
  handler_opts = {
    border = 'rounded',
  },
})

--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

-- UI
--  Change diagnostic symbols in gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Customizing how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
  float = {
      source = 'always',
  },
})


vim.g.coq_settings = {
    auto_start = 'shut-up',
}

local coq = require('coq')

require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA" },
}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['html'].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = lsp_flags,
}))
require('lspconfig')['tsserver'].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["tsserver"] = {}
    }
}))
require('lspconfig')['jsonls'].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = lsp_flags,
}))

require('lspconfig')['psalm'].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = lsp_flags,
    cmd = {'/home/ludovic-gonthier/.config/composer/vendor/vimeo/psalm/psalm-language-server'},
}))

require('lspconfig')['intelephense'].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        intelephense = {
            licenseKey= '00FTPSCN8ODXLIC',
            completion= {
                insertUseDeclaration= true,
                fullyQualifyGlobalConstantsAndFunctions= false,
                triggerParameterHints= true,
                maxItems= 15
            },
            files= {
                maxSize= 1000000,
                exclude = {
                    "**/.DS_Store/**",
                    "**/.git/**",
                    "**/.hg/**",
                    "**/.history/**",
                    "**/.svn/**",
                    "**/CVS/**",
                    "**/bower_components/**",
                    "**/node_modules/**",
                    "**/var/cache/**",
                    "**/vendor/**/vendor/**",
                    "**/vendor/**/{Tests,tests}/**",
                }
            },
            format= {
                enable= false
            },
            telemetry = {
                enabled = true
            },
            trace = {
                server = "messages"
            },
        }
    }
}))
