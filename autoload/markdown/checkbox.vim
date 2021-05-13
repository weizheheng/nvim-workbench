let s:bullet = '^\s*\%(\d\+\.\|[-+*]\)'

function! markdown#checkbox#toggle(...) abort
	let c = a:0 ? a:1 : toupper(escape(nr2char(getchar()), '\.*'))

	if c !~ '\p'
		return
	endif

	call search(s:bullet, 'bcW')

	for i in range(v:count1)
		try
			execute 'keeppatterns s/' . s:bullet . '\s\+\[\zs.\ze\]/\=submatch(0) == c ? " " : c/'
		catch /E486/
			execute 'keeppatterns s/' . s:bullet . '\s\zs/[' '] /'
		endtry

		if i < v:count1 - 1 && !search(s:bullet, 'W')
			break
		endif
	endfor

	if exists('*repeat#set')
		call repeat#set(":\<C-u>call markdown#checkbox#toggle('" . c . "')\<CR>")
	endif
endfunction
