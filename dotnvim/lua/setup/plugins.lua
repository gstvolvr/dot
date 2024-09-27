local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

function get_setup(name)
  return string.format('require("setup/%s")', name)
end

local packer = require('packer')

packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }
  -- use { 'nvim-tree/nvim-web-devicons' }
  use 'nvim-lua/plenary.nvim'
  use 'numToStr/Comment.nvim'
  use "rebelot/kanagawa.nvim"

  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons',
  --   },
  --   tag = 'nightly',
  --   config = get_setup('nvim-tree'),
  -- }
  --use {
  --    'nvim-treesitter/nvim-treesitter',
  --    run = function()
  --        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
  --        ts_update()
  --    end,
  --}

  -- use { 'nvim-lualine/lualine.nvim',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons',
  --     opt = true
  --   },
  --   config = get_setup('lualine'),
  -- }

  -- use { 'tpope/vim-fugitive' }

  -- use { 'tpope/vim-commentary' }

  -- use { 'mg979/vim-visual-multi' }

  -- use { 'sainnhe/everforest',
  --   config = get_setup('colorscheme'),
  -- }

  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = get_setup('telescope'),
  }
  use { 'nvim-telescope/telescope-file-browser.nvim' }

  -- use { 'hrsh7th/nvim-cmp',
  --   requires = {
  --     'neovim/nvim-lspconfig',
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --     'hrsh7th/cmp-cmdline',
  --     'hrsh7th/nvim-cmp',
  --     'L3MON4D3/LuaSnip',
  --     'saadparwaiz1/cmp_luasnip',
  --     'onsails/lspkind.nvim',
  --   },
  --   config = get_setup('cmp'),
  -- }

  -- use { 'rmagatti/goto-preview',
  --   config = get_setup('goto-preview'),
  -- }
    -- getting rust to work: https://github.com/simrat39/rust-tools.nvim
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'

  -- Debugging
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'

  -- inspiration from : https://dotfyle.com/neovim/colorscheme/top
  use { "rose-pine/neovim", as = "rose-pine" }
  require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
    end,
   })


  -- vim.cmd("colorscheme rose-pine")
  -- vim.cmd("colorscheme rose-pine-main")
  vim.cmd("colorscheme rose-pine-moon")
  -- vim.cmd("colorscheme rose-pine-dawn")

  if packer_bootstrap then
    packer.sync()
  end
end)
