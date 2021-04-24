" search() returns 0 if it the pattern was not found
function <SID>SearchCheck()
  return (search('\[\]', 'nc', line('.')) || search('\[\]', 'nbc', line('.')))
endfunction

" Edit markdown lists
" Add and remove bullets with ease
" If we are already checked then we uncheck
nnoremap <expr> <silent> <buffer> <Plug>WorkbenchToggle <SID>SearchCheck() ? ':.s/\[\]/\[x\]<Enter>': ':.s/\[x\]/\[\]<Enter>' 
nnoremap <silent> <buffer> <Plug>NormalWorkbenchAdd i-[] 
inoremap <silent> <buffer> <Plug>InsertWorkbenchAdd -[] 
