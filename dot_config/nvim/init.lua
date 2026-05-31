-------------------------------------------------------------------------------
--- Init
--------------------------------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

--------------------------------------------------------------------------------
--- Key Mappings
--------------------------------------------------------------------------------
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

-- Ctrl-Z seems to minimise nvim and go back to the terminal so disabling
vim.keymap.set({'n', 'v', 'i'}, '<C-z>', '<Nop>')

-- Tab between buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')

--------------------------------------------------------------------------------
--- Settings
--------------------------------------------------------------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true -- Highlights the line you're on
vim.o.termguicolors = true

vim.o.breakindent = true -- When text wraps to the next line, honours the indent
vim.o.confirm = true -- Prompt for confirmation if closing without saving
vim.o.ignorecase = true -- Make searches case-insensitive
vim.o.mouse = 'a' -- Enable the mouse
vim.o.scrolloff = 10 -- Scroll down when x numbers of lines left
vim.o.showmode = false -- Shows "INSERT", etc. Mini sets this to false
vim.o.signcolumn = 'yes' -- Needed for git signs or the column will keep moving
vim.o.smartcase = true -- If you start using upper case then go case sensitive
vim.o.undofile = true -- Persist undos across edit sessions by saving to file
vim.o.updatetime = 200 -- How quick things update after typing. Fast is better

-- Force splits in the right place
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.list = true -- List invisible characters like spaces at the end of a line
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

--------------------------------------------------------------------------------
--- Lazy Plugin Manager
--------------------------------------------------------------------------------
require('config.lazy')

--------------------------------------------------------------------------------
--- Final Steps
--------------------------------------------------------------------------------
vim.cmd('set showtabline=0') -- Hide buffers names as we use telescope

-- Make the Neo-Tree popup windows look nicer:
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Links popup background to your statusline background
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "StatusLine" })
    -- Links popup borders to standard window separators
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "WinSeparator" })
  end,
})

-- Run the above immediately for current session
vim.api.nvim_set_hl(0, "NormalFloat", { link = "StatusLine" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "WinSeparator" })
