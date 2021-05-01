local project_workbench = require('workbench.project_workbench')
local branch_workbench = require('workbench.branch_workbench')

local workbench = {}

workbench.toggle_branch_workbench = function()
  branch_workbench.toggle()
end

workbench.toggle_project_workbench = function()
  project_workbench.toggle()
end

return workbench
