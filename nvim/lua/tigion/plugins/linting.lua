return {
  'mfussenegger/nvim-lint',
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      -- javascriptreact = { 'eslint_d' },
      -- typescriptreact = { 'eslint_d' },
      -- svelte = { 'eslint_d' },
      python = { 'pylint' },
      -- python = { 'flake8' },
      -- python = { "ruff" },
      markdown = { 'markdownlint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
        lint.try_lint('codespell')
      end,
    })

    vim.keymap.set('n', '<Leader>l', function()
      lint.try_lint()
      lint.try_lint('codespell')
    end, { desc = 'Trigger linting for current file' })
  end,
}