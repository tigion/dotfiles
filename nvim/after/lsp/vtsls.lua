local vue_language_server_path = vim.fn.expand('$MASON/packages')
  .. '/vue-language-server'
  .. '/node_modules/@vue/language-server'

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
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
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
