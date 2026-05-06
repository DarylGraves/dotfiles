return {
  'Shatur/neovim-session-manager',
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,
  config = function()
    local config = require('session_manager.config')
    require('session_manager').setup({
      -- This order tells it: "Check the current folder. If nothing exists, STOP."
      autoload_mode = { config.AutoloadMode.CurrentDir, config.AutoloadMode.Disabled },
      
      autosave_last_session = true,
      
      -- This is critical when running just 'nvim' without arguments. 
      -- It forces the plugin to ignore the "Global Last Session".
      autoload_ignore_not_last_session = true,
      
      -- Prevents the plugin from trying to "be helpful" and find a 
      -- session in a parent directory (like your home folder).
      autosave_only_in_session = true, 
    })
  end,
}
