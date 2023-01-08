local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    separator_style = "slant",
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
  highlights = {
    tab_selected = {
      fg = '#fdf6e3',
      bg = '#002b36',
    },
    tab_separator_selected = {
      fg = '#002b36',
      bg = '#002b36',
    },
    tab = {
      fg = '#657b83',
      bg = '#073642'
    },
    tab_separator = {
      bg = '#073642',
      fg = '#073642',
    },
    tab_close = {
      fg = '#657b83',
      bg = '#073642'
    },
    --
    close_button = {
      fg = '#657b83',
      bg = '#002b36',
      --fg = '#ff0000',
      --bg = '#ffff00',
    },
    --
    separator = {
      fg = '#073642',
      bg = '#002b36',
    },
    separator_selected = {
      fg = '#073642',
    },
    background = {
      fg = '#657b83',
      bg = '#002b36'
    },
    buffer_selected = {
      fg = '#fdf6e3',
      bold = true,
    },
    fill = {
      bg = '#073642'
    }
  },
})

vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', {})
