return {
  {
     'nvim-mini/mini.nvim',
     config = function()
       -- Status Line
       local statusline = require 'mini.statusline'
       statusline.setup { use_icons = true }
       -- Pairs
       local pairs = require 'mini.pairs'
       pairs.setup {
	  modes = { insert = true, command = false, terminal = false },
	  mappings = {
	    ['('] = { action = 'open', pair = '()', neigh_pattern = '^[^\\]' },
	    ['['] = { action = 'open', pair = '[]', neigh_pattern = '^[^\\]' },
	    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '^[^\\]' },

	    [')'] = { action = 'close', pair = '()', neigh_pattern = '^[^\\]' },
	    [']'] = { action = 'close', pair = '[]', neigh_pattern = '^[^\\]' },
	    ['}'] = { action = 'close', pair = '{}', neigh_pattern = '^[^\\]' },

	    ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '^[^\\]',   register = { cr = false } },
	    ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '^[^%a\\]', register = { cr = false } },
	    ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '^[^\\]',   register = { cr = false } },
	  },
       }
     end
  }
}
