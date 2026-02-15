return {
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          registries = {
            'github:mason-org/mason-registry',
            'github:Crashdummyy/mason-registry',
          },
        },
      },
      'neovim/nvim-lspconfig',
    },
    config = function()
      local lspconfig = require('lspconfig')

      -- We put everything inside the main setup call.
      -- This bypasses the setup_handlers nil error entirely.
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'pyright', 'powershell_es' },
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({})
          end,
        },
      })

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = '●',
        },
        severity_sort = true,
        float = { border = 'rounded' },
      })
    end,
  },
}
