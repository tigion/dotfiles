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
}
