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

---Returns some information about the current buffer like
---file infos and cursor position. Returns nil for unnamed buffers.
---@return table|nil
local function get_buffer_info()
  local full_file_path = vim.api.nvim_buf_get_name(0)
  if full_file_path == '' then return nil end

  local cwd = vim.fn.getcwd()

  -- Get the relative file path from the current working directory.
  -- Falls back to an absolute path (with ~ expansion) if outside CWD.
  local rel_file_path = vim.fn.fnamemodify(full_file_path, ':~:.')

  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  return {
    file = {
      cwd = cwd,
      full_path = full_file_path,
      relative_path = rel_file_path,
      filetype = vim.bo.filetype,
    },
    cursor = {
      line = cursor_pos[1], -- 1-based line number.
      col = cursor_pos[2] + 1, -- Convert to a 1-based column number.
    },
  }
end

---Cleans up the given text lines from the minimum
---indentation and trailing whitespaces.
---@param lines string[]
---@return string[]
local function normalize_lines(lines)
  if #lines == 0 then return lines end

  -- Find the minimum indentation of the lines.
  local min_indentation = math.huge
  for _, line in ipairs(lines) do
    local _, e = line:find('^%s+')
    min_indentation = math.min(min_indentation, e or 0)
  end

  -- Remove the minimum indentation and trailing whitespaces.
  local normalized = {}
  for i, line in ipairs(lines) do
    normalized[i] = line:sub(min_indentation + 1):gsub('%s+$', '')
    -- normalized[i] = normalized[i]:gsub('\\', '\\\\') --  TODO: Are mask backslashes needed?
  end

  return normalized
end

---Returns the current visual selection information.
---or nil if not in visual mode.
---@return table|nil
local function get_visual_selection()
  local mode = vim.fn.mode()

  -- Return nil if not in a visual mode.
  if mode ~= 'v' and mode ~= 'V' and mode ~= '\22' then return nil end

  -- Leave visual mode to write the selection marks.
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'xn', false)

  -- Get the start and end positions of the visual selection.
  local start_pos = vim.fn.getcharpos("'<")
  local end_pos = vim.fn.getcharpos("'>")

  -- Correct the order of the start and end positions
  -- if the start position is after the end position.
  if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
    start_pos, end_pos = end_pos, start_pos
  end

  local start_row = start_pos[2]
  local start_col = start_pos[3]
  local end_row = end_pos[2]
  local end_col = end_pos[3]

  local selected_lines = vim.fn.getregion(start_pos, end_pos, { type = mode })
  -- local selected_lines = vim.fn.getregion(start_pos, end_pos, { type = vim.fn.visualmode() })

  -- Preserve the indentation of the first line in visual mode.
  if mode == 'v' and #selected_lines > 1 and start_col > 1 then
    local prefix = vim.fn.getline(start_row):sub(1, start_col - 1)
    selected_lines[1] = prefix:gsub('[^%s]', ' ') .. selected_lines[1]
  end

  selected_lines = normalize_lines(selected_lines)

  return {
    mode = mode,
    start_row = start_row,
    start_col = start_col,
    end_row = end_row,
    end_col = end_col,
    text = selected_lines,
  }
end

---Copies the current buffer context to the clipboard.
---@param opts? { notify?: boolean }
function M.copy_context_to_clipboard(opts)
  opts = opts or {}
  local notify = opts.notify == true -- Default to false.

  local info = get_buffer_info()

  if not info then
    if notify then vim.notify('No valid buffer context to copy.') end
    return
  end

  local selection = get_visual_selection()

  -- Build the file string with the selection range or cursor position.
  local suffix
  if selection then
    if selection.mode == 'v' then
      suffix = (':%d:%d-%d:%d'):format(selection.start_row, selection.start_col, selection.end_row, selection.end_col)
    else
      if selection.start_row == selection.end_row then
        suffix = (':%d'):format(selection.start_row)
      else
        suffix = (':%d-%d'):format(selection.start_row, selection.end_row)
      end
    end
  else
    suffix = (':%d:%d'):format(info.cursor.line, info.cursor.col)
  end
  local file_str = '@' .. info.file.relative_path .. (suffix or '')

  -- Build the selection string as a code block if there is a visual selection.
  local selection_str = nil
  if selection and #selection.text > 0 then
    selection_str = ('```%s\n%s\n```'):format(info.file.filetype, table.concat(selection.text, '\n'))
  end

  local context_str = file_str .. (selection_str and '\n\n' .. selection_str or '')

  if notify then vim.notify(context_str) end

  -- Copy the context string to the clipboard.
  vim.fn.setreg('+', context_str)
end

return M
