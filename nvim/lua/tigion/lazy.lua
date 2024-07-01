-- Bootstrap lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Util functions

---Returns the first path from a set of paths in which
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
    if vim.fn.isdirectory(vim.fn.expand(path) .. '/' .. plugin.name) == 1 then return path end
  end
  return search_paths[1]
end

-- Setup lazy.nvim

---@type LazySpec
local spec = {
  { import = 'tigion.plugins' },
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
}

require('lazy').setup(spec, opts)
-- require('lazy').setup(opts)
