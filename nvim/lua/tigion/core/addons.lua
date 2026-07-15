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

---Cleans up the given text lines from the minimum
---indentation and trailing whitespaces.
---@param lines string[]
---@return string[]
local function normalize_lines(lines)
  -- Find the minimum indentation of the lines.
  local min_indentation = math.huge
  for _, line in ipairs(lines) do
    local _, e = line:find('^%s+')
    min_indentation = math.min(min_indentation, e or 0)
  end

  -- Remove the minimum indentation and trailing whitespaces.
  for i, line in ipairs(lines) do
    lines[i] = line:sub(min_indentation + 1):gsub('%s+$', '')
    -- mask backslashes
    -- lines[i] = lines[i]:gsub('\\', '\\\\')
  end

  return lines
end

---Returns some information of the current buffer like
---file infos, cursor position, selection.
---@return table
local function get_buffer_info()
  local info = {}

  -- Get the file infos of the current buffer:
  local cwd = vim.fn.getcwd()
  local full_file_path = vim.api.nvim_buf_get_name(0)
  local rel_file_path = vim.fn.fnamemodify(full_file_path, ':.')
  info.file = {
    full_path = full_file_path,
    relative_path = rel_file_path,
    cwd = cwd,
    filetype = vim.bo.filetype,
  }

  -- Get the current cursor position:
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local cursor = {
    line = cursor_pos[1],
    col = cursor_pos[2] + 1, -- Uses 1-based instead of 0-based indexing.
  }
  info.cursor = cursor

  -- Get the current visual selection.
  local mode = vim.fn.mode()
  if mode:match('[vV\22]') then -- The "\22" is Ctrl-V (visual block).
    -- Leave visual mode to write the selection marks.
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'xn', false)

    -- Get the start and end positions of the visual selection.
    local start_pos = vim.fn.getcharpos("'<")
    local end_pos = vim.fn.getcharpos("'>")

    -- Correct the order of the start and end positions
    -- if the start position is after the end position.
    if start_pos[2] > end_pos[2] or start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3] then
      local tmp = start_pos
      start_pos = end_pos
      end_pos = tmp
    end

    local start_row = start_pos[2]
    local start_col = start_pos[3]
    local end_row = end_pos[2]
    local end_col = end_pos[3]

    local selected_lines = vim.fn.getregion(start_pos, end_pos, { type = mode })
    -- local selection = vim.fn.getregion(start_pos, end_pos, { type = vim.fn.visualmode() })

    -- Fill the first line with spaces in visual mode and multi line selection.
    if mode == 'v' and start_row ~= end_row and start_col > 1 then
      selected_lines[1] = string.rep(' ', start_col - 1) .. selected_lines[1]
    end

    selected_lines = normalize_lines(selected_lines)

    -- Set the selection info.
    info.selection = {
      mode = mode,
      start_row = start_row,
      start_col = start_col,
      end_row = end_row,
      end_col = end_col,
      text = selected_lines,
    }
  end

  return info
end

---Copies the current buffer context to the clipboard.
function M.copy_context_to_clipboard()
  local info = get_buffer_info()

  -- Build the file string.
  local file = '@' .. info.file.relative_path
  if info.selection then
    if info.selection.mode == 'V' then
      file = file .. ':' .. info.selection.start_row .. '-' .. info.selection.end_row
    elseif info.selection.mode == 'v' then
      file = file
        .. ':'
        .. info.selection.start_row
        .. ':'
        .. info.selection.start_col
        .. '-'
        .. info.selection.end_row
        .. ':'
        .. info.selection.end_col
    end
  else
    file = file .. ':' .. info.cursor.line .. ':' .. info.cursor.col
  end

  -- Build the selection string.
  local selection = ''
  if info.selection and #info.selection.text > 0 then
    selection = selection .. '```' .. info.file.filetype .. '\n'
    selection = selection .. table.concat(info.selection.text, '\n') .. '\n'
    selection = selection .. '```\n'
  end

  -- Build the context string.
  local context = ''
  if file ~= '' then context = context .. file .. '\n\n' end
  if selection ~= '' then context = context .. selection end

  -- Print the context string.
  vim.notify(context)

  -- Copy the context string to the clipboard.
  vim.fn.setreg('+', context)
end

return M
