local floatnote = {}

floatnote.open = function()
  local gwidth = vim.api.nvim_list_uis()[1].width
  local gheight = vim.api.nvim_list_uis()[1].height
  local width = math.floor(gwidth * 0.8)
  local height = math.floor(gheight * 0.8)
  local buf
  local win
  buf = vim.api.nvim_create_buf(false, true)

  win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = (gheight - height) / 2,
    col = (gwidth - width) / 2,
    style = "minimal",
    border = "single",
  })
  vim.cmd.edit("~/dev/notes/todo.md")

  vim.opt.number = true
  vim.opt.relativenumber = true

  vim.keymap.set("n", "q", function()
    vim.cmd("w")
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })
  end, { buffer = buf })
  vim.keymap.set("n", "<Esc>", function()
    vim.cmd("w")
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })
  end, { buffer = buf })
end

return floatnote
