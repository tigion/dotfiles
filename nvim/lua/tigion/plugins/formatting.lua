return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      '<Leader>f',
      function()
        print('Formatting...')
        require('conform').format({
          async = false,
          lsp_format = 'fallback',
          timeout_ms = 1000,
        })
      end,
      mode = { 'n', 'v' }, -- FIX: Format in visual mode doesn't work! (Use `<Cmd>=<CR>` as an alternative?)
      desc = 'Format buffer or selection',
    },
  },
  opts = {
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
      -- black = {
      --   prepend_args = { '--fast', '--line-length', '120' },
      -- },
      pint = {
        prepend_args = { '--preset', 'psr12' },
      },
    },
  },
}
