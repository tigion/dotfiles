return {
  -- This plugin adds a Lightweight yet powerful formatter to Neovim.
  -- Link: https://github.com/stevearc/conform.nvim

  'stevearc/conform.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<Leader>cf',
      function()
        require('conform').format({
          async = true,
          -- lsp_format = 'fallback',
          timeout_ms = 5000,
        })
        vim.notify(
          'Formatted ' .. (vim.api.nvim_get_mode().mode == 'n' and 'buffer' or 'selection'),
          vim.log.levels.INFO,
          { id = 'toggle_conform', title = 'Conform' }
        )
      end,
      mode = { 'n', 'x' },
      desc = 'Format buffer or selection',
    },
    {
      '<Leader>tf',
      function()
        vim.g.conform_disable_format_on_save = not vim.g.conform_disable_format_on_save
        vim.notify(
          'Format on save: ' .. (vim.g.conform_disable_format_on_save and 'OFF' or 'ON'),
          vim.log.levels.INFO,
          { id = 'toggle_conform', title = 'Conform' }
        )
      end,
      desc = 'Toggle format on save',
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
      zsh = { 'shfmt' },
      -- gitconfig = { 'trim_whitespace', 'trim_newlines', 'my_auto_indent' },
      -- gitignore = { 'trim_whitespace', 'trim_newlines' }, -- Do not format.
      -- tmux = { 'trim_whitespace', 'trim_newlines' }, -- Do not format.
      -- kitty = { 'trim_whitespace', 'trim_newlines' }, -- Do not format.
      -- filetypes that don't have other formatters
      ['_'] = { 'trim_whitespace', 'trim_newlines', lsp_format = 'last' },
      -- ['_'] = { 'trim_whitespace', 'trim_newlines', 'my_auto_indent' },
      -- all filetypes
      -- ['*'] = { '' },
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = function()
      if vim.g.conform_disable_format_on_save then return end
      return {
        async = false,
        timeout_ms = 5000,
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
}
