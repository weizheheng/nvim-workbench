lua require('workbench')

" Check if the directory and file is created

nnoremap <silent> <leader>b :lua require('workbench').toggle()<CR>

" Update title upon file create. 
autocmd bufnewfile workbench.md call append(0, '# ' . split(expand('%:p:h:t'), '\v\n')[0] . " Workbench!")


