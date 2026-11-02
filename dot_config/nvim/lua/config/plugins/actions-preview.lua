return {
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      vim.keymap.set({ "n", "v" }, "<A-.>", require("actions-preview").code_actions)
    end,
  }
}
