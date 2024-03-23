local floatnote = {}

vim.g.floatnote_open = false

local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = math.floor(gwidth * 0.8)
local height = math.floor(gheight * 0.8)
local buf
local win

floatnote.open = function()
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

  vim.keymap.set("n", "q", floatnote.close, { buffer = buf })
  vim.keymap.set("n", "<Esc>", floatnote.close, { buffer = buf })
end

floatnote.close = function()
  vim.cmd("w")
  vim.api.nvim_win_close(win, true)
  vim.api.nvim_buf_delete(buf, { force = true })
end

floatnote.toggle = function()
  if vim.g.floatnote_open then
    floatnote.close()
    vim.g.floatnote_open = false
  else
    floatnote.open()
    vim.g.floatnote_open = true
  end
end

return floatnote
