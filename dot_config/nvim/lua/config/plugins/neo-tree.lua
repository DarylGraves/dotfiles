return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        "<leader>e",
        function()
          local nt = require("neo-tree.command")
          if vim.bo.filetype == "neo-tree" then
            vim.cmd("wincmd p")
          else
            nt.execute({ action = "focus", source = "filesystem", position = "right" })
          end
        end,
        desc = "Neo-tree Smart Jump",
      },
    },
    opts = {
      window = {
        position = 'right',
      },
    },
  },
}
