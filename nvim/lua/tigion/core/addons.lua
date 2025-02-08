local M = {}

---Switches the word under the cursor to the opposite word.
-- Works only for `<cword>` words. First match is used.
--
-- NOTE: Better solution as plugin:
--       https://github.com/tigion/nvim-opposites
--
function M.switch_word_to_opposite_word_simple()
  local opposites = {
    ['enable'] = 'disable',
    ['true'] = 'false',
    ['True'] = 'False',
    ['yes'] = 'no',
    ['on'] = 'off',
    ['left'] = 'right',
    ['up'] = 'down',
    ['min'] = 'max',
  }
  local word = vim.fn.expand('<cword>')
  for w, ow in pairs(opposites) do
    if word == w then
      vim.cmd('normal! ciw' .. ow)
      break
    end
    if word == ow then
      vim.cmd('normal! ciw' .. w)
      break
    end
  end
end

return M
