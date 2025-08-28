return {
  {
    -- This plugin improves the viewing of Markdown files in Neovim.
    -- Link: https://github.com/MeanderingProgrammer/render-markdown.nvim

    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.icons', -- if you use standalone mini plugins
      -- 'nvim-mini/mini.nvim', -- if you use the mini.nvim suite
    },
    ft = { 'markdown' },
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
  --   -- This plugin adds a Highly customisable markdown previewer to Neovim.
  --   -- Link: https://github.com/OXY2DEV/markview.nvim
  --
  --   'OXY2DEV/markview.nvim',
  --   lazy = false, -- Recommended
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     -- 'nvim-tree/nvim-web-devicons',
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
    -- This plugin adds a Markdown file preview in your browser to Neovim.
    -- Link: https://github.com/iamcco/markdown-preview.nvim

    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function() vim.fn['mkdp#util#install']() end,
  },
}
