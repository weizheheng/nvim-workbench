local workbench = {}

local default_path = vim.api.nvim_eval("$HOME") .. "/.cache/"

function is_git_repo()
  local bool = vim.api.nvim_eval('system("git rev-parse --is-inside-work-tree")')
  local parsed_bool = vim.api.nvim_call_function('split', {bool, '\n'})[1]
  -- local parsed_bool = vim.fn.split(bool, '\n')[1]
  return parsed_bool
end

repo_name = vim.api.nvim_eval('split(system("git rev-parse --show-toplevel"), "/")[-1]')
-- parsed_repo_name = vim.fn.split(repo_name, '\n')[1]
parsed_repo_name = vim.api.nvim_call_function('split', {repo_name, '\n'})[1]
workbench_path = default_path .. parsed_repo_name

function directory_not_exist()
  -- return vim.fn.glob(workbench_path) == ''
  return vim.api.nvim_call_function('glob', {workbench_path}) == ''
end

function workbench_file_path()
  return workbench_path  .. "/" .. "workbench.md"
end

function window_config(width, height)
  local shadow = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }

  if vim.api.nvim_call_function('has', {'nvim-0.5.0'}) == 1 then
    return {
      relative = "editor",
      width = width,
      height = height,
      col = (ui.width - width) / 2,
      row = (ui.height - height) / 2,
      style = 'minimal',
      focusable = false,
      border = shadow
    }
  else
    return {
      relative = "editor",
      width = width,
      height = height,
      col = (ui.width - width) / 2,
      row = (ui.height - height) / 2,
      style = 'minimal',
      focusable = false,
    }
  end
end

-- create a global bufnr
workbench_bufnr = vim.api.nvim_create_buf(false, true)

initialized = false

function round(float)
  return math.floor(float + .5)
end

function workbench.initialize()
  --Get the current UI
  ui = vim.api.nvim_list_uis()[1]

  local width = round(ui.width * 0.5)
  local height = round(ui.height * 0.5)

  initialized = true

  local win_id = vim.api.nvim_open_win(workbench_bufnr, true, window_config(width, height))

  open_file_cmd = "e" .. workbench_file_path()
  -- vim.cmd(open_file_cmd)
  vim.api.nvim_command(open_file_cmd)
end

function workbench.hide()
  -- hide the current window
  -- vim.api.nvim_win_hide(0)
  vim.api.nvim_command('hide')
end

function workbench.show()
  local width = round(ui.width * 0.5)
  local height = round(ui.height * 0.5)

  local default_config = {
    relative = "editor",
    width = width,
    height = height,
    col = (ui.width - width) / 2,
    row = (ui.height - height) / 2,
    style = 'minimal',
    focusable = false,
  }
  vim.api.nvim_open_win(workbench_bufnr, true, window_config(width, height))
end

function workbench.toggle()
  -- early return if not a git repo
  if is_git_repo() ~= "true" then
    return vim.api.nvim_err_writeln("Sorry, Workbench only works in a Git Repo")
  end

  -- Should not be here, but it will fix the problem i guess
  if directory_not_exist() then
    -- vim.fn.mkdir(workbench_path)
    vim.api.nvim_call_function('mkdir', {workbench_path})
  end


  -- override ui
  ui = vim.api.nvim_list_uis()[1]

  local buf_hidden = 0
  -- local buf_info = vim.fn.getbufinfo(workbench_file_path())[1]
  local buf_info = vim.api.nvim_call_function('getbufinfo', {workbench_file_path()})[1]

  if buf_info then
    buf_hidden = buf_info.hidden
  end

  local current_bufnr = vim.api.nvim_win_get_buf(0)

  if not initialized then
    workbench.initialize()
  elseif current_bufnr == workbench_bufnr then
    workbench.hide()
  elseif buf_hidden == 0 and buf_info.windows[1] then
    vim.api.nvim_set_current_win(buf_info.windows[1])
  else
    workbench.show()
  end
end

return workbench
