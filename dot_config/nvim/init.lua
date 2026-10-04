--------------------------------------------------------------------------------
--- Initialisation
--------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Syncing Neovim Clipboard with OS
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Highlight when yanking Text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlights when yanking (copying) text",
	group = vim.api.nvim_create_augroup("init-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

--------------------------------------------------------------------------------
--- Key Mappings
--------------------------------------------------------------------------------
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Focus on left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Focus on lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Focus on upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Focus on right window" })

-- Ctrl-Z closes Nvim so disabling
vim.keymap.set({ "n", "v", "i" }, "<C-z>", "<Nop>")

-- Tabbing between buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

-- Remove search highlights when pushing escale
vim.keymap.set("n", "<escape>", ":nohlsearch<CR>")

--------------------------------------------------------------------------------
--- Settings
--------------------------------------------------------------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true -- Highlights the current line
vim.o.termguicolors = true -- Maybe needed for Windows Terminal?

vim.o.breakindent = true -- Honours indents when text wraps to the next line
vim.o.confirm = true -- Promt for confirmation if closing without saving
vim.o.scrolloff = 10 -- If less than 10 lines, don't scroll
vim.o.signcolumn = "yes" -- Adds an colum for signs (e.g. Git '+' and '-')
vim.o.ignorecase = true -- Makes searches case-insensitive
vim.o.smartcase = true -- If you start using upper case, go case sensitive
vim.o.undofile = true -- Saves undos to a file to persist across sessions
vim.o.tabstop = 4 -- How large tab indentations are
vim.o.shiftwidth = 4 -- Without this, pushing tab prints 2x tabs

-- By default splits go above and left
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.list = true -- Display invisible characters (extra spaces, etc)
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.cmdheight = 0 -- Hide the built in status bar so only the plugin shows.

-- Folds TODO:Folds
--vim.opt.foldmethod = "indent"

--------------------------------------------------------------------------------
--- Plugin Manager
--------------------------------------------------------------------------------
require("config.lazy")
