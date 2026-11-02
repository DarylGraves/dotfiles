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
      filesystem = {
        clean_abandoned_buffers = true,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
        use_libuv_file_watcher = true,
      }
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
    end,
  },
}
