return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Explicitly require the module inside the config block
    -- This waits until the plugin is fully installed/loaded
    local status, configs = pcall(require, "nvim-treesitter.configs")
    if not status then
      vim.notify("Treesitter configs not found, skipping setup", vim.log.levels.WARN)
      return
    end

    configs.setup({
      ensure_installed = { "c_sharp", "lua", "vim", "vimdoc" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
