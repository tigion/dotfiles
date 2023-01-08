local status, zenMode = pcall(require, "zen-mode")
if (not status) then return end

zenMode.setup {
  window = {
    options = {
      --number = false,
    }
  },
}

vim.keymap.set('n', '<Leader>z', '<cmd>ZenMode<cr>', { silent = true })
