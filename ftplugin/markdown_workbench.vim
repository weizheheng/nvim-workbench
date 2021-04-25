" search() returns 0 if it the pattern was not found
function <SID>SearchCheck()
  return (search('\[ \]', 'nc', line('.')) || search('\[ \]', 'nbc', line('.')))
endfunction

" Toggle checkbox
nnoremap <expr> <silent> <Plug>WorkbenchToggle <SID>SearchCheck() ? ':s/\[.*\]/\[x\]<CR>': ':s/\[x\]/\[ \]<Enter>' 

" Create checkbox
" - testing -> - [ ] testing
" * testing -> * [ ] testing
" testing -> [ ] testing
nnoremap <expr> <silent> <Plug>WorkbenchAdd ':s/^\s*\(-<space>\\|\*<space>\)\?\zs\(\[[^\]]*\]<space>\)\?\ze./[ ]<space>/<CR>'
