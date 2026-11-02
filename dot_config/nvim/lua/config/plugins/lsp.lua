return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'folke/lazydev.nvim', -- 1. Enforce loading order first
      { 'mason-org/mason.nvim', opts = { registries = { 'github:mason-org/mason-registry', 'github:Crashdummyy/mason-registry' } } },
      'neovim/nvim-lspconfig',
      'saghen/blink.cmp',    -- 2. Keep this simple string reference
    },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        lua_ls = { settings = { Lua = {} } }, -- Clear to let lazydev work
        pyright = {},
        powershell_es = {},
        terraformls = {},
        tflint = {},
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
