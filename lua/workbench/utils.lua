local utils = {}

function remove_empty_line(string)
  return vim.api.nvim_call_function('split', {string, '\n'})[1]
end

function round(float)
  return math.floor(float + .5)
end

local default_path = vim.api.nvim_eval("$HOME") .. "/.cache/"
repo_name = vim.api.nvim_eval('split(system("git rev-parse --show-toplevel"), "/")[-1]')
parsed_repo_name = remove_empty_line(repo_name)
workbench_path = default_path .. parsed_repo_name

function utils.workbench_path()
  return workbench_path
end

function utils.is_git_repo()
  local bool = vim.api.nvim_eval('system("git rev-parse --is-inside-work-tree")')
  local parsed_bool = remove_empty_line(bool)
  return parsed_bool
end

function utils.directory_not_exist()
  return vim.api.nvim_call_function('glob', {workbench_path}) == ''
end

function utils.create_directory()
  vim.api.nvim_call_function('mkdir', {workbench_path})
end

function utils.get_git_branch()
  local branch = vim.api.nvim_call_function("system", {"git branch --show-current"})
  local parsed_branch = remove_empty_line(branch)
  return parsed_branch
end

function utils.hide_workbench()
  vim.api.nvim_command('hide')
end

function utils.show_workbench(bufnr)
  local width = round(ui.width * 0.5)
  local height = round(ui.height * 0.5)

  vim.api.nvim_open_win(bufnr, true, utils.window_config(width, height))
end


function utils.window_config(width, height)
  if vim.api.nvim_call_function('has', {'nvim-0.5.0'}) == 1 then
    return {
      relative = "editor",
      width = width,
      height = height,
      col = (ui.width - width) / 2,
      row = (ui.height - height) / 2,
      style = 'minimal',
      focusable = false,
      border = "double"
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


return utils
