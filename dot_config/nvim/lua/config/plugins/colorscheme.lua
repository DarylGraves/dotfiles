return {
  'datsfilipe/vesper.nvim',
     config = function()
       require('vesper').setup({
         transparent = true,
       })
       vim.cmd.colorscheme 'vesper'
     end,
}
