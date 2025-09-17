return {
  settings = {
    html = {
      format = {
        templating = true,
        wrapLineLength = 0,
        wrapAttributes = 'preserve-aligned',
        -- wrapAttributes = 'auto',
      },
    },
  },
  -- filetypes = { 'html', 'templ' }, -- default
  filetypes = { 'html', 'templ', 'htmldjango' },
}
