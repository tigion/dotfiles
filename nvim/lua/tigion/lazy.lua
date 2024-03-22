local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  dev = {
    --   path = '~/projects/neovim',
    --   -- patterns = { 'tigion' },

    ---Returns the first path from a set of paths in which
    ---the dev version of the plugin is located.
    ---@param plugin LazyPlugin
    ---@return string
    path = function(plugin)
      local search_paths = {
        '~/projects', -- default path, if not found in other paths
        '~/projects/neovim',
        '~/projects/neovim/fork',
        '~/projects/private/neovim',
        '~/projects/private/neovim/fork',
      }
      for _, path in ipairs(search_paths) do
        if vim.fn.isdirectory(vim.fn.expand(path) .. '/' .. plugin.name) == 1 then return path end
      end
      return search_paths[1]
    end,
  },
}

require('lazy').setup('tigion.plugins', opts)
