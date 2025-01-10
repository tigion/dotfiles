return {
  {
    -- This plugin configures LuaLS for editing your Neovim config by lazily
    -- updating your workspace libraries.
    -- Link: https://github.com/folke/lazydev.nvim

    'folke/lazydev.nvim',
    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
    },
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  -- { -- Optional addon for lazydev.nvim
  --   -- optional completion source for require statements and module annotations
  --   'hrsh7th/nvim-cmp',
  --   enabled = false,
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, {
  --       name = 'lazydev',
  --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  --     })
  --   end,
  -- },
  { -- Optional addon for lazydev.nvim
    -- optional blink completion source for require statements and module annotations
    'saghen/blink.cmp',
    enabled = true,
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    },
  },
}
