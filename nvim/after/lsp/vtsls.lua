local vue_language_server_path = vim.fn.expand('$MASON/packages')
  .. '/vue-language-server'
  .. '/node_modules/@vue/language-server'

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

local inlay_hints = {
  parameterNames = {
    enabled = 'all',
    -- suppressWhenArgumentMatchesName = true, -- default
  },
  parameterTypes = { enabled = true },
  variableTypes = {
    enabled = true,
    -- suppressWhenTypeMatchesName = false, -- default
  },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  enumMemberValues = { enabled = true }, -- typescript only
}

---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
  init_options = {},
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
    typescript = {
      inlayHints = inlay_hints,
    },
    javascript = {
      inlayHints = inlay_hints,
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
