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
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      -- svelte = { 'eslint_d' },
      -- python = { 'ruff' }, -- replaced with ruff_lsp
      -- python = { 'pylint' }, -- replaced with ruff
      -- python = { 'flake8' }, -- replaced with ruff
      markdown = { 'markdownlint-cli2' },
      -- markdown = { 'markdownlint' },
      -- json = { 'jsonlint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
        -- lint.try_lint('codespell') -- Deactivated: use typos_lsp instead
      end,
    })

    -- vim.keymap.set('n', '<Leader>l', function()
    --   lint.try_lint()
    --   lint.try_lint('codespell')
    -- end, { desc = 'Lint current buffer/file' })
  end,
}
