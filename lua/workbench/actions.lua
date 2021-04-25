local workbench = {}

local default_path = vim.g.workbench_storage_path or os.getenv("HOME") ..
                         "/.cache/"

-- -- some local variables
-- -- local width = 125
-- -- local height = 30
-- local shadow = {"╔", "═", "╗", "║", "╝", "═", "╚", "║"}
-- -- create a global bufnr
-- workbench_bufnr = vim.api.nvim_create_buf(false, true)
-- initialized = false


-- local function config_layout(args)
--     local args = args or {}
--     local ui = vim.api.nvim_list_uis()[1]

--     local width = args.width or round(ui.width * 0.5)
--     local height = args.height or round(ui.height * 0.5)
--     local columns = args.columns or (ui.width - width) / 2
--     local rows = args.rows or (ui.height - height) / 2

--     local default_config = {
--         relative = "editor",
--         width = width,
--         height = height,
--         col = columns,
--         row = rows,
--         style = 'minimal',
--         focusable = false,
--         border = shadow
--     }
--     vim.api.nvim_open_win(workbench_bufnr, true, default_config)
-- end

-- function workbench.show(args) config_layout(args) end

-- function workbench.initialize(args)
--     config_layout(args)

--     open_file_cmd = "e" .. workbench_file_path()
--     vim.cmd(open_file_cmd)
-- end

function is_git_repo()
  local bool = vim.api.nvim_eval('system("git rev-parse --is-inside-work-tree")')
  local parsed_bool = vim.fn.split(bool, '\n')[1]
  return parsed_bool
end

repo_name = vim.api.nvim_eval('split(system("git rev-parse --show-toplevel"), "/")[-1]')
parsed_repo_name = vim.fn.split(repo_name, '\n')[1]
workbench_path = default_path .. parsed_repo_name

function directory_not_exist()
  return vim.fn.glob(workbench_path) == ''
end

function workbench_file_path()
  return workbench_path  .. "/" .. "workbench.md"
end

-- some local variables
-- local width = 125
-- local height = 30
local shadow = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }
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
  local default_config = {
    relative = "editor",
    width = width,
    height = height,
    col = (ui.width - width) / 2,
    row = (ui.height - height) / 2,
    style = 'minimal',
    focusable = false,
    border = shadow
  }

  local win_id = vim.api.nvim_open_win(workbench_bufnr, true, default_config)

  open_file_cmd = "e" .. workbench_file_path()
  vim.cmd(open_file_cmd)
end

function workbench.hide()
  -- hide the current window
  vim.api.nvim_win_hide(0)
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
    border = shadow
  }
  vim.api.nvim_open_win(workbench_bufnr, true, default_config)
end

function workbench.toggle()
  -- early return if not a git repo
  if is_git_repo() ~= "true" then
    return vim.api.nvim_err_writeln("Sorry, Workbench only works in a Git Repo")
  end

  -- Should not be here, but it will fix the problem i guess
  if directory_not_exist() then
    vim.fn.mkdir(workbench_path)
  end


  -- override ui
  ui = vim.api.nvim_list_uis()[1]

  local buf_hidden = 0
  local buf_info = vim.fn.getbufinfo(workbench_file_path())[1]

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
