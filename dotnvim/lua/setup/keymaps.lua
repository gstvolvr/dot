local map = function(mode, key, result, opts)
  opts = opts or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    opts
  )
end

vim.g.mapleader = ' '

-- NORMAL --
map('n', '<leader>o', ':on<CR>') -- close other buffers
map('n', '<leader>vm', ':vsp $MYVIMRC<CR>') -- open config
map('n', '<leader>d', ':NvimTreeToggle<cr>')
map('n', '<leader>cd', ':NvimTreeFindFile<cr>')
map('n', '<C-l>', ':bnext<CR>')
map('n', '<C-h>', ':bprevious<CR>')
map('n', ';', ':')

-- git
map('n', '<leader>gs', ':G<CR>')

-- telescope (IntelliJ-style navigation)
map('n', '<leader>ff', ":lua require('telescope.builtin').find_files()<CR>") -- Cmd+Shift+O equivalent
map('n', '<leader>fs', ":lua require('telescope.builtin').lsp_document_symbols()<CR>") -- Cmd+O equivalent  
map('n', '<leader>fw', ":lua require('telescope.builtin').lsp_workspace_symbols()<CR>") -- workspace symbols
map('n', '<leader>fb', ":lua require('telescope.builtin').buffers()<CR>")
map('n', '<leader>fg', ":lua require('telescope.builtin').live_grep()<CR>") -- Cmd+Shift+F equivalent
map('n', '<leader>fr', ":lua require('telescope.builtin').lsp_references()<CR>") -- find references
map('n', '<leader>gb', ":lua require('telescope.builtin').git_branches()<CR>")
map('n', '<C-]>', ":lua require('telescope.builtin').lsp_definitions()<CR>")

-- preview
map('n', 'gd', ":lua require('goto-preview').goto_preview_definition()<CR>", { noremap=true }) -- get definition in preview
map('n', '<leader>q', ":lua require('goto-preview').close_all_win()<CR>", { noremap=true }) -- close all definition windows
map('n', 'gr', ":lua require('goto-preview').goto_preview_references()<CR>", { noremap=true }) -- get references (uses telescope)

-- LSP/Code actions (IntelliJ-style)
map('n', '<leader>a', ':lua vim.lsp.buf.code_action()<CR>') -- Alt+Enter equivalent
map('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>') -- Shift+F6 equivalent
map('n', '<leader>rf', ':lua vim.lsp.buf.format()<CR>') -- reformat code
map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>') -- go to implementation
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>') -- hover documentation

-- IntelliJ-like tool windows
map('n', '<leader>e', ':TroubleToggle<CR>') -- error/diagnostics panel
map('n', '<leader>s', ':SymbolsOutline<CR>') -- structure view
map('n', '<leader>x', ':TroubleToggle workspace_diagnostics<CR>') -- workspace diagnostics

-- INSERT --
map('i', 'jj', '<ESC>')

-- VISUAL --
map('v', '>', '>gv') -- keep visual highlight for indent/dedent
map('v', '<', '<gv')

map('v', 'J', ":m '>+1<cr>gv=gv") -- move visual text up/down
map('v', 'K', ":m '<-2<cr>gv=gv")
