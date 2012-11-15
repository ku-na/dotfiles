" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

"---latex suite---
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='dvi'
let g:Tex_ViewRule_dvi='pxdvi'
let g:Tex_ViewRule_pdf='acroread'
let g:Tex_CompileRule_dvi='platex -interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf='platex -interaction=nonstopmode $*;dvipdfmx -f ptex-ipaex.map $*'
