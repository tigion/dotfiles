-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Util functions

---Returns the first plugin directory from a set of paths in which
---the local dev version of the plugin is located.
---@param plugin LazyPlugin
---@return string
local function get_local_dev_path(plugin)
  local search_paths = {
    '~/projects/neovim', -- default path, if not found in other paths
    '~/projects/neovim/fork',
    '~/projects/private/neovim',
    '~/projects/private/neovim/fork',
  }
  for _, path in ipairs(search_paths) do
    local plugin_dir = vim.fn.expand(path) .. '/' .. plugin.name
    -- if vim.fn.isdirectory(plugin_dir) == 1 then return path end
    if vim.fn.isdirectory(plugin_dir) == 1 then return plugin_dir end
  end
  return ''
end

-- Setup lazy.nvim

---@type LazySpec
local spec = {
  { import = 'tigion.plugins' },
  { import = 'tigion.plugins.filetype' },
  { import = 'tigion.plugins.lsp' },
  { import = 'tigion.plugins.ui' },
}

---@type LazyConfig
local opts = {
  -- spec = spec,
  checker = {
    enabled = true, -- automatically check for plugin updates
    notify = false, -- get a notification when new updates are found
  },
  change_detection = {
    notify = false,
  },
  dev = {
    path = get_local_dev_path,
    -- path = '~/projects/neovim',
  },
  rocks = {
    enabled = false, -- disable luarocks support
  },
}

require('lazy').setup(spec, opts)
-- require('lazy').setup(opts)
