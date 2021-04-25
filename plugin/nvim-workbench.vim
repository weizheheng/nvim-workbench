lua require('workbench')

nnoremap <silent> <leader>b :lua require('workbench').toggle()<CR>
nmap ,a <Plug>WorkbenchAdd
nmap <leader><CR> <Plug>WorkbenchToggle

" Update title upon file create. 
autocmd bufnewfile workbench.md call append(0, '# ' . split(expand('%:p:h:t'), '\v\n')[0] . " Workbench!")


