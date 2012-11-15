"--- fortran ---
syntax on
set ruler

set shiftwidth=2
set showcmd
set wrapmargin=2
set ignorecase
set guioptions=agirLM"mT 
set vb t_vb= 
set mouse=a

let s:extfname = expand("%:e")
if s:extfname ==? "f90"
	let g:fortran_have_tabs=0
	let g:fortran_more_precise=1
	let b:fortran_free_source=1
	unlet! fortran_fixed_source
	let b:fortran_dialect="elf"
	let b:fortran_do_enddo=1
	source ~/.vim/fortran_indent.vim
elseif s:extfname ==? 'f95'
	let g:fortran_have_tabs=1
	let g:fortran_more_precise=1
	let b:fortran_free_source=1
	unlet! fortran_fixed_source
	let b:fortran_dialect="f95"
	let b:fortran_do_enddo=1
	source ~/.vim/fortran_indent.vim
else
	let b:fortran_fixed_source=1
	unlet! fortran_free_source
endif