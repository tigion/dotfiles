return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        css = { 'prettier' },
        html = { 'prettier' },
        javascript = { 'prettier' },
        json = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        php = { 'pint' },
        -- python = { 'isort', 'black' }, -- replaced with ruff-ls
        -- python = { 'black' }, -- replaced with ruff-ls
        -- python = { -- ruff is replaced with ruff-ls
        --   'ruff_fix', -- To fix lint errors. (ruff with argument --fix)
        --   'ruff_format', -- To run the formatter. (ruff with argument format)
        -- },
        sh = { 'shfmt' },
        typescript = { 'prettier' },
        vue = { 'prettier' },
        yaml = { 'prettier' },
        -- filetypes that don't have other formatters
        ['_'] = { 'trim_whitespace', 'trim_newlines' },
        -- all filetypes
        -- ['*'] = { '' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
      formatters = {
        black = {
          prepend_args = { '--fast', '--line-length', '120' },
        },
        pint = {
          prepend_args = { '--preset', 'psr12' },
        },
      },
    })

    vim.keymap.set(
      { 'n', 'v' },
      '<Leader>f',
      function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      { desc = 'Format buffer/file or selection' }
    )
  end,
}
