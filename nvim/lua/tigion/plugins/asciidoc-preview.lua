return {
  'tigion/nvim-asciidoc-preview',

  dev = false, -- When `true`, the local development version is used instead.

  ft = { 'asciidoc' },
  build = 'cd server && npm install',
  opts = {
    -- server = {
    --   port = 11234,
    --   converter = 'js',
    -- },
    -- preview = {
    --   position = 'current',
    -- },
  },
}
