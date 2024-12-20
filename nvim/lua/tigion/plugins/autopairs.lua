return {
  'windwp/nvim-autopairs', -- auto pairs (cmp, treesitter)
  event = 'InsertEnter',
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local autopairs = require('nvim-autopairs')

    autopairs.setup({
      disable_filetype = { 'TelescopePrompt', 'vim' },
      check_ts = true, -- enable treesitter
      ts_config = {
        -- it will not add a pair on that treesitter filetype nodes:
        lua = { 'string' },
        javascript = { 'template_string' },
        -- don't check treesitter on filetypes:
        java = false,
      },
    })

    -- TODO: Is this also for blink.cmp needed?
    --
    -- make autopairs and completion work together
    -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    -- local cmp = require('cmp')
    -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
