lua require('workbench')

" search() returns 0 if it the pattern was not found
function <SID>SearchCheck()
  return (search('\[ \]', 'nc', line('.')) || search('\[ \]', 'nbc', line('.')))
endfunction

" When there are no checkbox, it will add one
" - testing -> - [ ] testing
" Toggle checkbox
" - [ ] testing -> - [x] testing
" - [x] testing -> - [ ] testing
nnoremap <expr> <silent> <Plug>WorkbenchToggleCheckbox ":call markdown#checkbox#toggle('x')<CR>"

" Outdated no longer needed
" Toggle checkbox does the job now
" Create checkbox
" - testing -> - [ ] testing
" * testing -> * [ ] testing
" testing -> [ ] testing
nnoremap <expr> <silent> <Plug>WorkbenchAddCheckbox ':s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze./[ ]<space>/<CR>'

nnoremap <expr> <silent> <Plug>ToggleWorkbench ":lua require('workbench').toggle_project_workbench()<CR>"
nnoremap <expr> <silent> <Plug>ToggleProjectWorkbench ":lua require('workbench').toggle_project_workbench()<CR>"
nnoremap <expr> <silent> <Plug>ToggleBranchWorkbench ":lua require('workbench').toggle_branch_workbench()<CR>"

" Update project workbench title. 
autocmd bufnewfile workbench.md call append(0, '# ' . split(expand('%:p:h:t'), '\v\n')[0] . " Workbench!")
autocmd bufnewfile *branchbench.md call append(0, '# '. split(expand('%:p:h:t'), '\v\n')[0] . '--' . split(system('git branch --show-current', '\v\n'))[0] . " Workbench!")


