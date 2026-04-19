return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')

      -- 1. Ctrl+P: Find Files (local project files)
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })

      -- 2. Ctrl+S: Find Files in Neovim config
      vim.keymap.set('n', '<C-s>', function()
        builtin.find_files({
          cwd = vim.fn.stdpath('config'), -- Automatically finds your ~/.config/nvim
          hidden = true, -- Shows init.lua and other dotfiles
        })
      end, { desc = 'Telescope find nvim config' })

      -- Basic Telescope setup
      require('telescope').setup({
        extensions = {
          ['fzf'] = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      })

      -- Load the fzf extension if it's installed
      pcall(require('telescope').load_extension, 'fzf')
    end,
  },
}
