return {
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- Or relative, which means they will be resolved from the plugin dir.
        'lazy.nvim',
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
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
