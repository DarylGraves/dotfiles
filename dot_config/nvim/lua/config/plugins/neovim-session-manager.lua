return {
  'Shatur/neovim-session-manager',
  opts = {},
  config = function()
    local config = require('session_manager.config')
    require('session_manager').setup({
      autoload_mode = config.AutoloadMode.CurrentDir,
      autosave_last_session = true,
    })
    end,
}
