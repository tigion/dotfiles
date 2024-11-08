return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons', -- if you use standalone mini plugins
      -- 'echasnovski/mini.nvim', -- if you use the mini.nvim suite
      -- 'nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
    },
    -- ft = { 'markdown' },
    -- cmd = { 'RenderMarkdown' },
    keys = {
      {
        '<Leader>tm',
        '<Cmd>RenderMarkdown toggle<CR>',
        ft = 'markdown',
        desc = 'Toggle Render Markdown',
      },
    },
    opts = {
      enabled = false, -- Enable/disable by default (toggle with `<Leader>tm`)
      code = {
        sign = false,
        style = 'normal', -- Don't show icon + name for language (like 'full')
        width = 'block',
        left_pad = 1,
        right_pad = 1,
      },
      heading = {
        sign = false, -- Don't show icons in sign column
        icons = {}, -- Don't replace `#` with icons in heading column
        -- Workaround to have background highlights without disabling the rendering of headings
      },
    },
  },
  -- {
  --   'OXY2DEV/markview.nvim',
  --   lazy = false, -- Recommended
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   keys = {
  --     {
  --       '<Leader>tm',
  --       '<Cmd>Markview toggle<CR>',
  --       ft = 'markdown',
  --       desc = 'Toggle Markview',
  --     },
  --   },
  --   opts = {},
  -- },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function() vim.fn['mkdp#util#install']() end,
  },
  {
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
  },
}
