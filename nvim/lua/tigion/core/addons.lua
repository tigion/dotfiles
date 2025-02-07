local M = {}

---Switches the word under the cursor to the opposite word.
--
-- NOTE:
--     false            <- cursor at word end
--     | false          <- cursor in word
--     | | false        <- cursor at word start
--     | | |
-- 45678901234567890123 <- column/index in line
--     ^ ^ |   ^
--        word len:  5
--             col: 12
-- min_idx in line:  8 <- 12 - (5 - 1)
--             idx: 10
--
-- TODO:
-- - [x] user select by multiple words (current: first match only)
-- - [ ] use `vim.ui.select` instead of `vim.fn.inputlist`
--
---@return nil
function M.switch_word_to_opposite_word()
  local opposites = {
    ['enable'] = 'disable',
    ['true'] = 'false',
    ['True'] = 'False',
    ['yes'] = 'no',
    ['on'] = 'off',
    ['left'] = 'right',
    ['up'] = 'down',
    ['min'] = 'max',
    ['=='] = '!=',
    ['<='] = '>=',
    ['<'] = '>',
    -- ['abc'] = 'cba',
    -- ['abcd'] = 'xcba',
    -- ['ab'] = 'ba',
    -- ['bc'] = 'cb',
    -- ['abcde'] = 'edcba',
  }
  local max_line_length = 1000

  -- Gets the current line and the current cursor position.
  local current_line = vim.fn.getline('.')
  local current_column = vim.fn.col('.')

  -- Checks the max allowed line length.
  if current_line:len() > max_line_length then
    vim.notify(
      'Line too long: ' .. current_line:len() .. ' (max: ' .. max_line_length .. ')',
      vim.log.levels.ERROR,
      { title = 'Switch Word' }
    )
    return
  end

  -- Returns the index of the beginning of the word in the line.
  local function find_word_in_line(line, col, word)
    local min_idx = col - (#word - 1)
    local idx = string.find(line, word, min_idx)
    return idx ~= nil and idx <= col and idx or -1
  end

  -- Returns a line with the replaced word at the index in the line.
  local function replace_word_in_line(line, idx, old_word, new_word)
    local left_part = string.sub(line, 1, idx - 1)
    local right_part = string.sub(line, idx + #old_word)
    return left_part .. new_word .. right_part
  end

  -- Finds word or its opposite in the current line.
  local results = {}
  for w, ow in pairs(opposites) do
    -- Finds the word in the current line.
    local word, opposite_word = w, ow
    local idx = find_word_in_line(current_line, current_column, word)
    if idx ~= -1 then table.insert(results, { word = word, opposite_word = opposite_word, idx = idx }) end
    -- Finds the opposite word in the current line.
    word, opposite_word = ow, w
    idx = find_word_in_line(current_line, current_column, word)
    if idx ~= -1 then table.insert(results, { word = word, opposite_word = opposite_word, idx = idx }) end
  end

  -- Checks if we found any results.
  if #results < 1 then
    vim.notify('Could not find word in line', vim.log.levels.INFO, { title = 'Switch Word' })
    return
  end

  -- Sorts the results by length and then alphabetically.
  table.sort(results, function(a, b)
    if #a.word == #b.word then return a.word < b.word end
    return #a.word < #b.word
  end)

  -- Selects the relevant result.
  local results_idx = 1
  if #results > 1 then
    local choices = { 'Select:' }
    for i, v in ipairs(results) do
      table.insert(choices, i .. '. ' .. v.word .. ' -> ' .. v.opposite_word)
    end
    local i = vim.fn.inputlist(choices)
    if i == 0 or i == nil then return end
    results_idx = i
  end
  local result = results[results_idx]
  -- vim.notify('Found: ' .. result.word .. ' (' .. result.opposite_word .. ') at ' .. result.idx)

  -- Replaces the current line with a new line in which the word at
  -- the given index has been replaced by the opposite word.
  local new_line = replace_word_in_line(current_line, result.idx, result.word, result.opposite_word)
  vim.api.nvim_set_current_line(new_line)
end

---Switches the word under the cursor to the opposite word.
-- Works only for `<cword>` words. First match is used.
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
