local M = {}

---Inserts a filetype specific debug message of the current word under the cursor or
---the visual selection in a new line under the cursor.
--
-- yiw -> o -> vim.print( -> <Esc> -> p -> i -> ) -> <Esc>
function M.add_dbg_msg()
  local ft_messages = {
    -- ['lua'] = { 'vim.notify(', ')' },
    ['lua'] = { 'vim.print(vim.inspect((', ')))' },
    ['c'] = { 'printf("%s\n", ', ')' },
    ['python'] = { 'print(', ')' },
    ['javascript'] = { 'console.log(', ')' },
    ['typescript'] = { 'console.log(', ')' },
    ['java'] = { 'System.out.println(', ')' },
    -- ['cpp'] = { 'std::cout << ', ' << std::endl' },
    -- ['php'] = { 'echo ', ';' },
    ['sh'] = { 'echo "$', '"' },
  }

  -- Gets buffer filetype.
  local filetype = vim.bo.filetype
  if not ft_messages[filetype] then return end

  -- Gets current word under cursor or visual selection.
  local word = ''
  if vim.fn.mode() == 'v' then
    -- Gets current selection.
    local v_start = vim.fn.getpos('v')
    local v_end = vim.fn.getpos('.')
    word = table.concat(vim.fn.getregion(v_start, v_end), '')
    -- word = table.concat(vim.api.nvim_buf_get_text(0, v_start[2] - 1, v_start[3] - 1, v_end[2] - 1, v_end[3], {}))
  else
    -- Gets current word under cursor.
    word = vim.fn.expand('<cword>')
  end

  -- Creates debug message.
  local dbg_msg = (ft_messages[filetype][1] or '') .. word .. (ft_messages[filetype][2] or '')

  -- Inserts debug message in a new line under the cursor.
  vim.api.nvim_put({ dbg_msg }, 'l', true, true)
  -- vim.notify(dbg_msg)
end

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
