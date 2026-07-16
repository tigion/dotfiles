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

  local filetype = vim.bo.filetype
  if not ft_messages[filetype] then return end

  -- Get current word under cursor or visual selection.
  local word = ''
  if vim.fn.mode() == 'v' then
    -- Gets current selection.
    local v_start = vim.fn.getpos('v')
    local v_end = vim.fn.getpos('.')
    word = table.concat(vim.fn.getregion(v_start, v_end), '')
    -- word = table.concat(vim.api.nvim_buf_get_text(0, v_start[2] - 1, v_start[3] - 1, v_end[2] - 1, v_end[3], {}))
  else
    -- Get current word under cursor.
    word = vim.fn.expand('<cword>')
  end

  -- Create debug message.
  local dbg_msg = (ft_messages[filetype][1] or '') .. word .. (ft_messages[filetype][2] or '')

  -- Insert debug message in a new line under the cursor.
  vim.api.nvim_put({ dbg_msg }, 'l', true, true)
  -- vim.notify(dbg_msg)
end

function M.demo() vim.notify('Hello from demo function!') end

return M
