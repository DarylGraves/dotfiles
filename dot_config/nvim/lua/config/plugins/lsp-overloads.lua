return {
  "Issafalcon/lsp-overloads.nvim",
  event = "LspAttach",
  opts = {
    ui = {
      border = "single",
      max_height = 16, -- Increased to fit Fastify's multi-line generic overloads without truncation (@@@)
      max_width = 150, -- Wider bounds to avoid unnecessary line wraps
      wrap = true,     -- Prevents wrapping single parameters across multiple lines
      close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertLeave" },
    },
    keymaps = {
      next_signature = "<C-j>",     -- Cycle next overload
      previous_signature = "<C-k>", -- Cycle prev overload
      close_signature = "<Esc>",
    },
    display_automatically = true,
  },
  config = function(_, opts)
    require("lsp-overloads").setup(opts)

    -- Clean active parameter styling: Cyan text, bold, no underline
    vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
      fg = "#56b6c2",
      bg = "NONE",
      bold = true,
      underline = false,
    })
  end,
}
