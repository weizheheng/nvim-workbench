local project_workbench = {}
local utils = require('workbench.utils')

-- create a global bufnr
project_workbench_bufnr = vim.api.nvim_create_buf(false, true)
project_workbench_initialized = false

function project_workbench.filepath()
  return utils.workbench_path()  .. "/" .. "workbench.md"
end

function project_workbench.initialize()
  --Get the current UI
  ui = vim.api.nvim_list_uis()[1]

  local width = round(ui.width * 0.5)
  local height = round(ui.height * 0.5)

  project_workbench_initialized = true

  local win_id = vim.api.nvim_open_win(project_workbench_bufnr, true, utils.window_config(width, height))

  open_file_cmd = "e" .. project_workbench.filepath()
  vim.api.nvim_command(open_file_cmd)
end

function project_workbench.toggle()
  -- early return if not a git repo
  if utils.is_git_repo() ~= "true" then
    return vim.api.nvim_err_writeln("Sorry, Workbench only works in a Git Repo")
  end

  if utils.directory_not_exist() then
    utils.create_directory()
  end

  -- override ui every time toggle is called
  ui = vim.api.nvim_list_uis()[1]

  local buf_hidden = 0
  local buf_info = vim.api.nvim_call_function('getbufinfo', {project_workbench.filepath()})[1]

  if buf_info then
    buf_hidden = buf_info.hidden
  end

  local current_bufnr = vim.api.nvim_win_get_buf(0)

  if not project_workbench_initialized then
    project_workbench.initialize()
  elseif current_bufnr == project_workbench_bufnr then
    utils.hide_workbench()
  elseif buf_hidden == 0 and buf_info.windows[1] then
    vim.api.nvim_set_current_win(buf_info.windows[1])
  else
    utils.show_workbench(project_workbench_bufnr)
  end
end

return project_workbench
