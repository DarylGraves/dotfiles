--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
--- Settings
--------------------------------------------------------------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true -- Highlights the line you're on

vim.o.breakindent = true -- When text wraps to the next line, honours the indent
vim.o.confirm = true -- Prompt for confirmation if closing without saving
vim.o.ignorecase = true -- Make searches case-insensitive
vim.o.mouse = 'a' -- Enable the mouse
vim.o.scrolloff = 10 -- Scroll down when x numbers of lines left
vim.o.showmode = true -- Shows "INSERT", etc. Plugins may need this set to false
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
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

--------------------------------------------------------------------------------
--- Plugins
--------------------------------------------------------------------------------
require('lazy').setup({
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  { -- Comment toggling with Ctrl+/
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      -- Ctrl+/ (terminal reports this as Ctrl+_)
      vim.keymap.set('n', '<C-/>', function()
        require('Comment.api').toggle.linewise.current()
      end, { silent = true })

      vim.keymap.set('v', '<C-/>', function() -- Same but for visual
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        require('Comment.api').toggle.linewise(vim.fn.visualmode())
      end, { silent = true })
    end,
  },
  { -- Adds git related signs to the gutter
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { -- Auto pairs - When type ( add ), etc
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
--------------------------------------------------------------------------------
--- LSP Plugins
--------------------------------------------------------------------------------
  { -- Lua
    'folke/lazydev.nvim', 
    ft = 'lua',
  },
--------------------------------------------------------------------------------
--- Color Theme
--------------------------------------------------------------------------------
  {
    'datsfilipe/vesper.nvim',
    config = function()
      vim.cmd.colorscheme 'vesper'
    end,
  },
})

