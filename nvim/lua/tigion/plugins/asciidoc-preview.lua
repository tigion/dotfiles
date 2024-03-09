return {
  'tigion/nvim-asciidoc-preview', -- variant for official plugin
  -- dir = '~/projects/neovim/nvim-asciidoc-preview', -- variant for local plugin development

  -- enabled = false,
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
