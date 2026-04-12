return {
  'numToStr/FTerm.nvim',
  config = function()
    local fterm = require("FTerm")

    -- 1. Optional: Configure how it looks
    fterm.setup({
      border = 'rounded',
      dimensions = {
        height = 0.8,
        width = 0.8,
      },
    })

    -- 2. Create a Keybinding (Alt + i) 
    -- 'n' is for Normal mode, 't' is for Terminal mode (so you can close it too)
    vim.keymap.set('n', '<leader>tt', fterm.toggle, { desc = 'Toggle Terminal' })
    vim.keymap.set('t', '<leader>tt', fterm.toggle, { desc = 'Toggle Terminal' })

    -- 3. Create the :FTermToggle command so it shows up in your command bar
    vim.api.nvim_create_user_command('FTermToggle', fterm.toggle, {})
  end,
}
