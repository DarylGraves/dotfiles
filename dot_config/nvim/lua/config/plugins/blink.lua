return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },

  version = '1.*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Simplified keymap using the built-in super-tab preset
    keymap = { 
      preset = 'super-tab',
      -- You can still override specific keys if you like <CR> for accept
      ['<CR>'] = { 'accept', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono',
      -- Keeps compatibility with nvim-cmp highlight groups
      use_nvim_cmp_as_default = true,
    },

    snippets = { preset = 'luasnip' },

    completion = { 
      documentation = { auto_show = false },
      -- If multiple providers return the same item, this helps keep the list clean
      list = { selection = { preselect = true, auto_insert = true } },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- Logic to omit conflicting providers if necessary
      providers = {
        snippets = { score_offset = 100 },
      },
    },

    -- Changed to 'prefer_rust' as per your reference for better performance
    fuzzy = { implementation = 'prefer_rust' },
  },
  opts_extend = { 'sources.default' },
}
