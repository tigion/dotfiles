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
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
        typescript = { 'prettier' },
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
      '<leader>f',
      function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      { desc = 'Format file or range (in visual mode)' }
    )
  end,
}
