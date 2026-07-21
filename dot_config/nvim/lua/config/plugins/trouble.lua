return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    modes = {
      diagnostics = {
        keys = {
          ["<cr>"] = "jump_close",
        },
      },
      todo = {
        win = {
          position = "right",
          size = 120,
        },
        keys = {
          ["<cr>"] = "jump_close",
        },
        sort = { "text", "pos" },
      },
    },
  },
  keys = {
    {
      "<leader>x",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>X",
      "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>n",
      "<cmd>Trouble todo toggle focus=true<cr>",
      desc = "Todo Comments Pane (Trouble)",
    },
  },
}
