return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      { 'mason-org/mason.nvim', opts = { registries = { 'github:mason-org/mason-registry', 'github:Crashdummyy/mason-registry' } } },
      'neovim/nvim-lspconfig',
      'saghen/blink.cmp',
    },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Specialized settings for specific servers
      local servers = {
        lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
        pyright = {},
        powershell_es = {},
        terraformls = {},
      }

      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = capabilities
            lspconfig[server_name].setup(server)
          end,
        },
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        -- Adds the icons back to the gutter
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        },
        virtual_text = { source = 'if_many', spacing = 4, prefix = '●' },
      })
    end,
  },
}
