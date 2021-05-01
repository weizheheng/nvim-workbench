lua require('workbench')

" search() returns 0 if it the pattern was not found
function <SID>SearchCheck()
  return (search('\[ \]', 'nc', line('.')) || search('\[ \]', 'nbc', line('.')))
endfunction

" Toggle checkbox
" - [ ] testing -> - [x] testing
" - [x] testing -> - [ ] testing
nnoremap <expr> <silent> <Plug>WorkbenchToggleCheckbox <SID>SearchCheck() ? ':s/\[.*\]/\[x\]<CR>': ':s/\[x\]/\[ \]<Enter>' 

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


