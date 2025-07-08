return {
  {
    -- This plugin adds a simple AsciiDoc preview while editing AsciiDoc
    -- documents to Neovim.
    -- Link: https://github.com/tigion/nvim-asciidoc-preview

    'tigion/nvim-asciidoc-preview',
    dev = false, -- When `true`, the local development version is used instead.
    ft = { 'asciidoc' },
    build = 'cd server && npm install --omit=dev',
    ---@module 'asciidoc-preview'
    ---@type asciidoc-preview.Config
    opts = {
      server = {
        --   port = 11234,
        converter = 'cmd', -- js or cmd
      },
      -- preview = {
      --   position = 'current',
      -- },
    },
  },
}
