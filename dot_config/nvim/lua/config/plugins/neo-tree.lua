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
            nt.execute({ action = "close"})
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
        mappings = {
          ["<C-n>"] = "add",
          ["<C-f>"] = "add_directory",
          ["<Del>"] = "delete",
        }
      },
    },
    config = function(_, opts)
      -- Apply the highlights here
      vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#ffffff", bg = "NONE" }) 
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff" }) -- A nice green border
      
      -- Call the standard setup with your opts
      require("neo-tree").setup(opts)
    end,
  },
}
