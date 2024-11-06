return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      '<Leader>cf',
      function()
        require('conform').format({
          async = false,
          lsp_format = 'fallback',
          timeout_ms = 1000,
        })
      end,
      mode = { 'n', 'x' }, -- FIX: Format in visual mode doesn't work! (Use `<Cmd>=<CR>` as an alternative?)
      desc = 'Format buffer or selection',
    },
  },
  opts = {
    formatters_by_ft = {
      css = { 'prettier' },
      html = { 'prettier' },
      javascript = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier', 'markdownlint-cli2' },
      -- php = { 'pint' }, -- Pint is built on top of PHP-CS-Fixer
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
      gitconfig = { 'trim_whitespace', 'trim_newlines', 'my_auto_indent' },
      -- filetypes that don't have other formatters
      ['_'] = { 'trim_whitespace', 'trim_newlines' },
      -- all filetypes
      -- ['*'] = { '' },
    },
    -- format_on_save = {
    --   lsp_format = 'fallback',
    --   async = false,
    --   timeout_ms = 1000,
    -- },
    format_on_save = function()
      if vim.g.conform_disable_format_on_save then return end
      return {
        lsp_format = 'fallback',
        async = false,
        timeout_ms = 1000,
      }
    end,
    formatters = {
      -- black = {
      --   prepend_args = { '--fast', '--line-length', '120' },
      -- },
      -- pint = {
      --   prepend_args = { '--preset', 'psr12' },
      -- },
      -- shfmt = {
      --   -- Fixed in https://github.com/stevearc/conform.nvim/commit/acc7d93f4a080fec587a99fcb36cffa29adc4bad
      --   -- shfmt ignores `.editorconfig` in conform.nvim
      --   -- Workaround: Use `-ci` global in `prepend_args`
      --   prepend_args = { '-ci' }, -- Switch cases will be indented (--case-indent)
      -- },

      -- Custom formatter to auto indent buffer.
      -- - Indents with neovim's builtin indentation `=`.
      -- - Saves and restores cursor position in ` mark.
      my_auto_indent = {
        format = function(_, ctx, _, callback)
          -- no range, use whole buffer otherwise use selection
          local cmd = ctx.range == nil and 'gg=G' or '='
          vim.cmd.normal({ 'm`' .. cmd .. '``', bang = true })
          callback()
        end,
      },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)

    -- https://github.com/stevearc/conform.nvim/issues/39
    -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
    vim.api.nvim_create_user_command(
      'ConformFormatOnSaveToggle',
      function() vim.g.conform_disable_format_on_save = not vim.g.conform_disable_format_on_save end,
      {
        desc = 'Toggle format on save',
        bang = true,
      }
    )

    vim.keymap.set(
      'n',
      '<Leader>tf',
      ':ConformFormatOnSaveToggle<CR>',
      { desc = 'Toggle format on save', noremap = true, silent = true }
    )
  end,
}
