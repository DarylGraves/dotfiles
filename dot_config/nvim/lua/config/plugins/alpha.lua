  return {
    "goolord/alpha-nvim",
    -- dependencies = { 'nvim-mini/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      require("alpha").setup(
        dashboard.config
      )
      dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("p", "󰈞  Find project files", ":Telescope find_files<CR>"),
            dashboard.button("s", "󰒓  Open config", ":lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config'), hidden = true})<CR>"),
            dashboard.button("r", "󰊄  Recently opened files", ":Telescope oldfiles<CR>"),
            dashboard.button("g", "󰈬  Find word (Grep)", ":Telescope live_grep<CR>"),
            dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
          }

          -- This part ensures the "shortcut" character (like 'p') is highlighted correctly
          for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
          end

          require("alpha").setup(dashboard.config)
    end,
  }
