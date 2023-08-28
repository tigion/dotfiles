return {
  'norcalli/nvim-colorizer.lua', -- colored color codes
  config = function()
    local status, colorizer = pcall(require, 'colorizer')
    if (not status) then return end

    colorizer.setup {
      '*',
    }
  end,
}