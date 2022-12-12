local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- Auto compile when there are changes in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'

local packer_bootstrap = ensure_packer()return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}

    use 'dense-analysis/ale'
    -- ColorScheme
    use 'jnurmine/zenburn'

    use 'powerman/vim-plugin-AnsiEsc' -- Don't know where it is used

    -- Syntaxt Highlight
    use {
        -- 'sheerun/vim-polyglot' -- Maybe exchange for TreeSitter instead?
        { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
        {
            "tree-sitter/tree-sitter-php",
            run = ":TSInstall php",
            requires = 'nvim-treesitter/nvim-treesitter'
        },
        {
            "tree-sitter/tree-sitter-json",
            run = ":TSInstall json",
            requires = 'nvim-treesitter/nvim-treesitter'
        },
        {
            "tree-sitter/tree-sitter-javascript",
            run = ":TSInstall javascript",
            requires = 'nvim-treesitter/nvim-treesitter'
        },
        {
            "derekstride/tree-sitter-sql",
            run = ":TSInstall sql",
            requires = 'nvim-treesitter/nvim-treesitter'
        },
        {
            "MunifTanjim/tree-sitter-lua",
            run = ":TSInstall lua",
            requires = 'nvim-treesitter/nvim-treesitter'
        },
        {
            "gbprod/tree-sitter-twig",
            run = ":TSInstall twig",
            requires = 'nvim-treesitter/nvim-treesitter'
        },
        {
            "tree-sitter/tree-sitter-html",
            run = ":TSInstall html",
            requires = 'nvim-treesitter/nvim-treesitter'
        },
    }

    -- Wiki
    use 'vimwiki/vimwiki'

    -- Misc
    use {
        'editorconfig/editorconfig-vim',
        'nelstrom/vim-visual-star-search',
        'tpope/vim-commentary',
        'tpope/vim-unimpaired',
        'skywind3000/asyncrun.vim', -- Used only for generating CTags
    }

    -- Note writing
    use {
        'xolox/vim-notes',
        requires = 'xolox/vim-misc',
    }

    -- File versionning
    use 'tpope/vim-fugitive'

    -- StatusLine
    use {
        'vim-airline/vim-airline',
        'vim-airline/vim-airline-themes'
    }

    -- FileTree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use {
        'folke/trouble.nvim',
        requires = "kyazdani42/nvim-web-devicons",
    }

    -- LSP - The order here is important --
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'ray-x/lsp_signature.nvim',
        {
            'ms-jpq/coq_nvim',
            branch = 'coq',
            -- commit = '84ec5faf2aaf49819e626f64dd94f4e71cf575bc',
            run = { ':COQdeps', ':COQsnips compile'},
        },
        { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
        { 'ms-jpq/coq.thirdparty', branch = '3p' },
        {
            'neovim/nvim-lspconfig',
            wants = { 'lsp_signature.nvim', 'coq_nvim' },
        },
    }
    -- Fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }

    -- CPP --
    use { 'puremourning/vimspector',
        run = './install_gadget.py --enable-c',
        ft = {'c', 'cpp', 'c++', 'h', 'hpp'}
    }
    use {
        'jackguo380/vim-lsp-cxx-highlight',
        ft = {'c', 'cpp', 'c++', 'h', 'hpp'}
    }

    -- C Sharp --
    use {
        'OmniSharp/omnisharp-vim',
        ft = {'cs'}
    }

    -- Markdown --
    use {
        'instant-markdown/vim-instant-markdown',
        ft = {'md'},
        run = 'yarn install'
    }

    -- Org Mode --
    use {
        'tpope/vim-speeddating',
        ft='org'
    }
    use {
        'mattn/calendar-vim',
        ft='org'
    }
    use {
        'vim-scripts/utl.vim',
        ft='org'
    }

    -- PHP --
    use {
        'rayburgemeestre/phpfolding.vim',
        ft={'php'}
    }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
