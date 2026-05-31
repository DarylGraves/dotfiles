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
    keymap = { 
      -- Merged overrides from your old LSP file configuration:
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-space>'] = { 'show', 'show_documentation', 'hide' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono',
      use_nvim_cmp_as_default = true,
    },

    snippets = { preset = 'luasnip' },

    completion = { 
      documentation = { auto_show = true },
      list = { selection = { preselect = true, auto_insert = true } },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = 'prefer_rust' },
  },
  opts_extend = { 'sources.default' },
}
