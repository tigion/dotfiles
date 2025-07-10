-- local vue_typescript_plugin = require('mason-registry').get_package('vue-language-server'):get_install_path()
--   .. '/node_modules/@vue/language-server'
--   .. '/node_modules/@vue/typescript-plugin'

local vue_typescript_plugin = vim.fn.expand('$MASON/bin/vue-language-server')
  .. '/node_modules/@vue/language-server'
  .. '/node_modules/@vue/typescript-plugin'

-- local preferences = {
--   importModuleSpecifierPreference = 'relative',
--   includeCompletionsForModuleExports = true,
--   includeCompletionsWithInsertText = true,
--   quotePreference = 'auto',
--   allowTextChangesInNewFiles = true,
--   providePrefixAndSuffixTextForRename = true,
--   allowRenameOfImportPath = true,
--   provideRefactorNotApplicableReason = true,
--   includeAutomaticOptionalChainCompletions = true,
--   includeCompletionsForImportStatements = true,
--   includeCompletionsWithSnippetText = true,
--   completeFunctionCalls = true,
-- }
local inlay_hints = {
  includeInlayParameterNameHints = 'all',
  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  init_options = {
    -- plugins = {
    --   {
    --     name = '@vue/typescript-plugin',
    --     location = vue_typescript_plugin,
    --     languages = { 'vue' },
    --     -- languages = { "javascript", "typescript", "vue" },
    --   },
    -- },
  },
  settings = {
    typescript = {
      inlayHints = inlay_hints,
    },
    javascript = {
      inlayHints = inlay_hints,
    },
  },
}
