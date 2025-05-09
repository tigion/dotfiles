-- local vue_typescript_plugin = require('mason-registry').get_package('vue-language-server'):get_install_path()
--   .. '/node_modules/@vue/language-server'
--   .. '/node_modules/@vue/typescript-plugin'

local vue_typescript_plugin = vim.fn.expand('$MASON/bin/vue-language-server')
  .. '/node_modules/@vue/language-server'
  .. '/node_modules/@vue/typescript-plugin'

return {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_typescript_plugin,
        languages = { 'vue' },
      },
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
