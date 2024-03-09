return {
  'tigion/nvim-asciidoc-preview',

  dev = false, -- When `true`, the local development version is used instead.

  cmd = { 'AsciiDocPreview' },
  ft = { 'asciidoc' },
  build = 'cd server && npm install',
  opts = {
    server = {
      converter = 'js',
    },
    preview = {
      position = 'sync',
    },
  },
}
