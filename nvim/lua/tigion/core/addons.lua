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

---Clears the given text lines from the minimum
---indentation and trailing whitespaces.
---@param lines string[]
---@return string[]
local function clear_selection(lines)
  -- Finds the minimum indentation of the lines.
  local min_indentation = math.huge
  for _, line in ipairs(lines) do
    local _, e = line:find('^%s+')
    min_indentation = math.min(min_indentation, e)
  end

  -- Removes the minimum indentation and trailing whitespaces.
  for i, line in ipairs(lines) do
    lines[i] = line:sub(min_indentation + 1):gsub('%s+$', '')
    -- mask backslashes
    -- lines[i] = lines[i]:gsub('\\', '\\\\')
  end

  return lines
end

---Returns some information of the current buffer like
---file path, cursor position, selection.
---@return table
local function get_buffer_info()
  local info = {}

  -- Gets the file infos of the current buffer:
  local cwd = vim.fn.getcwd()
  local full_file_path = vim.api.nvim_buf_get_name(0)
  local rel_file_path = vim.fn.fnamemodify(full_file_path, ':.')
  info.file = {
    full_path = full_file_path,
    relative_path = rel_file_path,
    cwd = cwd,
    filetype = vim.bo.filetype,
  }

  -- Gets the current cursor position:
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local cursor = {
    line = cursor_pos[1],
    col = cursor_pos[2] + 1, -- Uses 1-based instead of 0-based indexing.
  }
  info.cursor = cursor

  -- Gets the current visual selection.
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' or mode == '\22' then -- The "\22" is Ctrl-V (visual block).
    local start_pos = vim.fn.getpos('v') -- The visual start position.
    local end_pos = vim.fn.getpos('.') -- The cursor position.

    -- Corrects the order of the start and end positions
    -- if the start position is after the end position.
    if start_pos[2] > end_pos[2] or start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3] then
      local tmp = start_pos
      start_pos = end_pos
      end_pos = tmp
    end

    -- Gets the lines of the selection.
    local lines
    if mode == 'V' then
      lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
    elseif mode == '\22' then
      lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
      for i, line in ipairs(lines) do
        lines[i] = line:sub(start_pos[3], end_pos[3])
      end
    else
      lines = vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], {})
    end

    lines = clear_selection(lines)

    -- Sets the selection info.
    info.selection = {
      mode = mode,
      start_line = start_pos[2],
      start_col = start_pos[3],
      end_line = end_pos[2],
      end_col = end_pos[3],
      text = lines,
    }
  end

  return info
end

function M.copy_context_to_clipboard()
  local info = get_buffer_info()

  -- Builds the file string.
  local file = '@' .. info.file.relative_path
  if info.selection then
    if info.selection.mode == 'V' then
      file = file .. ':' .. info.selection.start_line .. '-' .. info.selection.end_line
    else
      file = file
        .. ':'
        .. info.selection.start_line
        .. ':'
        .. info.selection.start_col
        .. '-'
        .. info.selection.end_line
        .. ':'
        .. info.selection.end_col
    end
  else
    file = file .. ':' .. info.cursor.line .. ':' .. info.cursor.col
  end

  -- Builds the selection string.
  local selection = ''
  if info.selection and #info.selection.text > 0 then
    selection = selection .. '```' .. info.file.filetype .. '\n'
    selection = selection .. table.concat(info.selection.text, '\n') .. '\n'
    selection = selection .. '```\n'
  end

  -- Builds the context string.
  local context = ''
  if file ~= '' then context = context .. file .. '\n\n' end
  if selection ~= '' then context = context .. selection end

  -- Prints the context string.
  vim.notify(context)

  -- Copies the context string to the clipboard.
  vim.fn.setreg('+', context)
end

return M
