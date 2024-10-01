local function delete_pair()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  print("Cursor position:", row, col)
  print("Current line:", line)

  if col == 0 then return end 

  local char_deleted = line:sub(col, col)
  print("Character deleted:", char_deleted)
  local char_pairs = {
    ["{"] = "}",
    ["("] = ")",
    ["["] = "]",
    ["'"] = "'",
    ['"'] = '"',
    ["<"] = ">",
    ["$"] = "$"
  }

  local char_closing = char_pairs[char_deleted]
  if char_closing then
    local char_next = line:sub(col + 1, col + 1)
    print("Next character:", char_next)
    if char_next == char_closing then
      local new_line = line:sub(1, col - 1) .. line:sub(col + 2)
      vim.api.nvim_set_current_line(new_line)
      vim.api.nvim_win_set_cursor(0, {row, col - 1})
      print("Pair deleted")
    end
  end
end

vim.api.nvim_create_autocmd("TextChangedI", {
  pattern = "*",
  callback = delete_pair,
})
