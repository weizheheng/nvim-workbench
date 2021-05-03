local branch_workbench = {}
local utils = require('workbench.utils')

branch_workbench_bufnr = vim.api.nvim_create_buf(false, true)
branch_workbench_initialized = false

function branch_workbench.filepath()
  -- for git flow the branch name is something like feature/ch1234/branch_name
  local git_branch = utils.get_git_branch()
  local parsed_git_branch = vim.api.nvim_call_function('join', {vim.api.nvim_call_function('split', {git_branch, '/'}), "-"})
  return utils.workbench_path()  .. "/" .. parsed_git_branch .. "-branchbench.md"
end


function branch_workbench.initialize()
  --Get the current UI
  ui = vim.api.nvim_list_uis()[1]

  local width = round(ui.width * 0.5)
  local height = round(ui.height * 0.5)

  branch_workbench_initialized = true

  local win_id = vim.api.nvim_open_win(branch_workbench_bufnr, true, utils.window_config(width, height))

  open_file_cmd = "e " .. branch_workbench.filepath()
  vim.api.nvim_command(open_file_cmd)
end

function branch_workbench.toggle()
  -- early return if not a git repo
  if utils.is_git_repo() ~= "true" then
    return vim.api.nvim_err_writeln("Sorry, Workbench only works in a Git Repo")
  end

  if utils.directory_not_exist(utils.workbench_path()) then
    utils.create_directory()
  end

  -- override ui every time toggle is called
  ui = vim.api.nvim_list_uis()[1]

  local buf_hidden = 0
  local buf_info = vim.api.nvim_call_function('getbufinfo', {branch_workbench.filepath()})[1]

  if buf_info then
    buf_hidden = buf_info.hidden
  end

  local current_bufnr = vim.api.nvim_win_get_buf(0)

  if not branch_workbench_initialized then
    branch_workbench.initialize()
  elseif current_bufnr == branch_workbench_bufnr then
    utils.hide_workbench()
  elseif buf_hidden == 0 and buf_info.windows[1] then
    vim.api.nvim_set_current_win(buf_info.windows[1])
  else
    utils.show_workbench(branch_workbench_bufnr)
  end
end


return branch_workbench
