return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      -- Status Line
      local statusline = require('mini.statusline')
      statusline.setup({ use_icons = true })

      local comment = require('mini.comment')
      comment.setup({
        mappings = {
          -- Toggle comments with Ctrl+/
          comment = '<C-_>',
          comment_line = '<C-_>',
          comment_visual = '<C-_>',
          textobject = '<C-_>',
        },
      })

      -- Pairs
      local pairs = require('mini.pairs')
      pairs.setup({
        modes = { insert = true, command = false, terminal = false },
        mappings = {
          ['('] = { action = 'open', pair = '()', neigh_pattern = '^[^\\]' },
          ['['] = { action = 'open', pair = '[]', neigh_pattern = '^[^\\]' },
          ['{'] = { action = 'open', pair = '{}', neigh_pattern = '^[^\\]' },

          [')'] = { action = 'close', pair = '()', neigh_pattern = '^[^\\]' },
          [']'] = { action = 'close', pair = '[]', neigh_pattern = '^[^\\]' },
          ['}'] = { action = 'close', pair = '{}', neigh_pattern = '^[^\\]' },

          ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '^[^\\]', register = { cr = false } },
          ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '^[^%a\\]', register = { cr = false } },
          ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '^[^\\]', register = { cr = false } },
        },
      })

      -- Tablines
      local tabs = require('mini.tabline')
      tabs.setup({})

      -- Git
      local git = require('mini.git')
      git.setup({
        -- General CLI execution
        job = {
          -- Path to Git executable
          git_executable = 'git',

          -- Timeout (in ms) for each job before force quit
          timeout = 30000,
        },

        -- Options for `:Git` command
        command = {
          -- Default split direction
          split = 'auto',
        },
      })
    end,
  },
}
