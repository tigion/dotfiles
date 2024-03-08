return {
  'tigion/nvim-asciidoc-preview',
  -- dir = '~/projects/neovim/nvim-asciidoc-preview',
  -- enabled = false,
  cmd = { 'AsciiDocPreview' },
  ft = { 'asciidoc' },
  opts = {
    server = {
      converter = 'js',
    },
    preview = {
      position = 'sync',
    },
  },
}
