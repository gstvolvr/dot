require('setup.options')
require('setup.keymaps')
require('setup.plugins')

-- Basic settings
vim.o.number = true             -- Enable line numbers
vim.o.relativenumber = true     -- Enable relative line numbers
vim.o.tabstop = 4               -- Number of spaces a tab represents
vim.o.shiftwidth = 4            -- Number of spaces for each indentation
vim.o.expandtab = true          -- Convert tabs to spaces
vim.o.softtabstop = 4           -- Number of spaces that a <Tab> counts for while editing
vim.o.smartindent = true        -- Automatically indent new lines
vim.o.wrap = false              -- Disable line wrapping
vim.o.cursorline = true         -- Highlight the current line
vim.o.termguicolors = true      -- Enable 24-bit RGB colors
vim.o.hidden = true             -- Ensure hidden files are shown
vim.o.path = vim.o.path .. '**' -- Set the path to search for files

-- Make `:e` use the directory of the current file by default
-- vim.cmd [[
--   autocmd BufEnter * lcd %:p:h
-- ]]

-- Syntax highlighting and filetype plugins
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Leader key
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })

-- Use netrw for file browsing
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

-- Open the netrw file explorer in a vertical split
vim.api.nvim_set_keymap('n', '<leader>e', ':Vexplore<CR>', { noremap = true, silent = true })

-- Load Comment.nvim
require('Comment').setup()

-- Key mappings for commenting
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', 'gc', { noremap = true, silent = true })

vim.o.termguicolors = true
vim.cmd [[
  colorscheme slate
  set background=dark
]]

-- Function to prompt for a directory and search within it
function SearchInDirectory()
  local opts = {
    prompt_title = "Search in Directory",
    cwd = vim.fn.input("Enter directory: ", "", "file")
  }
  require('telescope.builtin').find_files(opts)
end

-- Create a command to prompt for a directory and search within it
vim.api.nvim_set_keymap('n', '<leader>d', ':lua SearchInDirectory()<CR>', { noremap = true, silent = true })

-- Map `;` to `:` to enter command mode more easily
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true, silent = false })
vim.api.nvim_set_keymap('v', ';', ':', { noremap = true, silent = false })


-- Function to trim trailing whitespace
local function trim_trailing_whitespace()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[ %s/\s\+$//e ]])
    vim.fn.setpos(".", save_cursor)
end

-- Autocommand to trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = trim_trailing_whitespace,
})

local telescope = require('telescope')
local fb_actions = require "telescope._extensions.file_browser.actions"

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.api.nvim_buf_set_option(0, 'modifiable', true)
  end,
})

telescope.setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<A-c>"] = fb_actions.create,  -- Alt + c to create file/folder
          ["<S-CR>"] = fb_actions.create_from_prompt,  -- Shift + Enter to create from prompt
        },
        ["n"] = {
          ["c"] = fb_actions.create,  -- c to create file/folder
        },
      },
    },
  },
}

telescope.load_extension('file_browser')
vim.cmd("colorscheme kanagawa-wave")
--vim.cmd("colorscheme kanagawa-dragon")
--vim.cmd("colorscheme kanagawa-lotus")
