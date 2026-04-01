return {
  -- This plugin adds image support to Neovim.
  -- Link: https://github.com/3rd/image.nvim

  '3rd/image.nvim',
  enabled = false,
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  ft = { 'markdown' },
  opts = {
    backend = 'kitty',
    processor = 'magick_cli',
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        download_remote_images = true,
        only_render_image_at_cursor = true,
        filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
        resolve_image_path = function(document_path, image_path, fallback)
          --
          -- FIX: Workaround to correct unrecognized file path names like:
          -- - `![img](image%202.png)` -> `image%202.png` -> `image 2.png`
          -- - `![img](<image 2.png>)` -> `<image 2.png>` -> `image 2.png`
          --
          -- replace '%20' with ' '
          image_path = image_path:gsub('%%20', ' ')
          -- remove '<' at the beginning and '>' at the end
          image_path = image_path:gsub('^<', ''):gsub('>$', '')

          return fallback(document_path, image_path)
        end,
      },
      neorg = { enabled = false },
      typst = { enabled = false },
      html = { enabled = false },
      css = { enabled = false },
    },
  },
}
