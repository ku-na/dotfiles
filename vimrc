"=============================================================================
"    Description: .vimrcサンプル設定
"         Author: anonymous
"  Last Modified: 14-08-20 Wed 11:21 AM
"        Version: 0.00
"=============================================================================
set nocompatible
scriptencoding utf-8
" scriptencodingと、このファイルのエンコーディングが一致するよう注意！
" scriptencodingは、vimの内部エンコーディングと同じものを推奨します。
" 改行コードは set fileformat=unix に設定するとunixでも使えます。
set fileformat=unix

"----------------------------------------
" ユーザーランタイムパス設定
"----------------------------------------
" Windows, unixでのruntimepathの違いを吸収するためのもの。
" $MY_VIMRUNTIMEはユーザーランタイムディレクトリを示す。
" :echo $MY_VIMRUNTIMEで実際のパスを確認できます。
if isdirectory($HOME . '/.vim')
  let $MY_VIMRUNTIME = $HOME.'/.vim'
elseif isdirectory($HOME . '\vimfiles')
  let $MY_VIMRUNTIME = $HOME.'\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
  let $MY_VIMRUNTIME = $VIM.'\vimfiles'
endif

" ランタイムパスを通す必要のあるプラグインを使用する場合、
" $MY_VIMRUNTIMEを使用すると Windows/Linuxで切り分ける必要が無くなります。
" 例) vimfiles/qfixapp (Linuxでは~/.vim/qfixapp)にランタイムパスを通す場合
" set runtimepath+=$MY_VIMRUNTIME/qfixapp

"----------------------------------------
" 内部エンコーディング指定
"----------------------------------------
" 内部エンコーディングのUTF-8化と文字コードの自動認識設定をencode.vimで行う。
" オールインワンパッケージの場合 vimrcで設定されます。
" エンコーディング指定や文字コードの自動認識設定が適切に設定されている場合、
" 次行の encode.vim読込部分はコメントアウトして下さい。
silent! source $MY_VIMRUNTIME/pluginjp/encode.vim
" scriptencodingと異なる内部エンコーディングに変更する場合、
" 変更後にもscriptencodingを指定しておくと問題が起きにくくなります。
scriptencoding utf-8

"----------------------------------------
" システム設定
"----------------------------------------

" ファイルの上書きの前にバックアップを作る/作らない
" set writebackupを指定してもオプション 'backup' がオンでない限り、
" バックアップは上書きに成功した後に削除される。
set writebackup
" バックアップ/スワップファイルを作成する/しない
set backup
if version >= 703
  " 再読込、vim終了後も継続するアンドゥ(7.3)
  set undofile
  " アンドゥの保存場所(7.3)
  set undodir=.
endif
" set noswapfile
" viminfoを作成しない
" set viminfo=
" クリップボードを共有
set clipboard+=autoselect
set clipboard+=unnamed
" 8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
" キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeout timeoutlen=3000 ttimeoutlen=100
" 編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set hidden
" ヒストリの保存数
set history=50
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mM
" Visual blockモードでフリーカーソルを有効にする
set virtualedit=block
" カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
" バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
" □や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
" コマンドライン補完するときに強化されたものを使う
set wildmenu
" マウスを有効にする
if has('mouse')
  set mouse=a
endif
" pluginを使用可能にする
filetype plugin indent on

"----------------------------------------
" 検索
"----------------------------------------
" 検索の時に大文字小文字を区別しない
" ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
" 検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
" インクリメンタルサーチ
set incsearch
" 検索文字の強調表示
set hlsearch
" w,bの移動で認識する文字
set iskeyword=a-z,A-Z,48-57,_,.,-,>
" vimgrep をデフォルトのgrepとする場合internal
set grepprg=internal

"----------------------------------------
" 表示設定
"----------------------------------------
" スプラッシュ(起動時のメッセージ)を表示しない
" set shortmess+=I
" エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set noerrorbells
set novisualbell
set visualbell t_vb=
" マクロ実行中などの画面再描画を行わない
" WindowsXpまたはWindowテーマが「Windowsクラシック」で
" Google日本語入力を使用するとIビームカーソルが残る場合にも有効
set lazyredraw
" Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
" 行番号表示
set number
if version >= 703
  " 相対行番号表示(7.3)
  " set relativenumber
endif
" 括弧の対応表示時間
set showmatch matchtime=1
" タブを設定
"set ts=4 sw=4 sts=4
" 自動的にインデントする
set autoindent
set smartindent
" Cインデントの設定
set cinoptions+=:0
" タイトルを表示
set title
" コマンドラインの高さ (gvimはgvimrcで指定)
" set cmdheight=2
set laststatus=2
" コマンドをステータス行に表示
set showcmd
" 画面最後の行をできる限り表示する
set display=lastline
" Tab、行末の半角スペースを明示的に表示する
set list
set listchars=tab:^\ ,trail:~

" ハイライトを有効にする
if &t_Co > 2 || has('gui_running')
  syntax on
endif

""""""""""""""""""""""""""""""
" ステータスラインに文字コード等表示
" iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするFencB()を使用
""""""""""""""""""""""""""""""
if has('iconv')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\ 
else
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
endif

" FencB() : カーソル上の文字コードをエンコードに応じた表示にする
function! FencB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

"----------------------------------------
" diff/patch
"----------------------------------------
" diffの設定
if has('win32') || has('win64')
  set diffexpr=MyDiff()
  function! MyDiff()
    " 7.3.443 以降の変更に対応
    silent! let saved_sxq=&shellxquote
    silent! set shellxquote=
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let cmd = '!diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    silent execute cmd
    silent! let &shellxquote = saved_sxq
  endfunction
endif

" 現バッファの差分表示(変更箇所の表示)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" パッチコマンド
set patchexpr=MyPatch()
function! MyPatch()
   call system($VIM."\\'.'patch -o " . v:fname_out . " " . v:fname_in . " < " . v:fname_diff)
endfunction

"----------------------------------------
" ノーマルモード
"----------------------------------------
" ヘルプ検索
nnoremap <F1> K
" 現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
" 強制全保存終了を無効化
nnoremap ZZ <Nop>
" カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
" キーボードマクロには物理行移動を推奨
" h l は行末、行頭を超えることが可能に設定(whichwrap)
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv

"----------------------------------------
" 挿入モード
"----------------------------------------

"----------------------------------------
" ビジュアルモード
"----------------------------------------

"----------------------------------------
" コマンドモード
"----------------------------------------

"----------------------------------------
" Vimスクリプト
"----------------------------------------
""""""""""""""""""""""""""""""
" ファイルを開いたら前回のカーソル位置へ移動
" $VIMRUNTIME/vimrc_example.vim
""""""""""""""""""""""""""""""
augroup vimrcEx
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "normal! g`\"" | endif
augroup END

""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインのカラー変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
" if has('unix') && !has('gui_running')
"   " ESCですぐに反映されない対策
"   inoremap <silent> <ESC> <ESC>
" endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""""""""""""""""""""""""""""""
" 全角スペースを表示
""""""""""""""""""""""""""""""
" コメント以外で全角スペースを指定しているので、scriptencodingと、
" このファイルのエンコードが一致するよう注意！
" 強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
" scriptencoding cp932
function! ZenkakuSpace()
  silent! let hi = s:GetHighlight('ZenkakuSpace')
  if hi =~ 'E411' || hi =~ 'cleared$'
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  endif
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

""""""""""""""""""""""""""""""
" """"""""""""""""""""""""""""""
" if exists('+autochdir')
"   "autochdirがある場合カレントディレクトリを移動
"   set autochdir
" else
"   "autochdirが存在しないが、カレントディレクトリを移動したい場合
"   au BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
" endif

"----------------------------------------
" 各種プラグイン設定
"----------------------------------------
"--- Vundle でプラグイン管理 ---
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle!!
Plugin 'gmarik/Vundle.vim'
" vim-scripts repos
Plugin 'vimwiki'
Plugin 'sudo.vim'
Plugin 'SrcExpl'
Plugin 'Trinity'
Plugin 'taglist.vim'
Plugin 'VOoM'
" original repos on github
Plugin 'mattn/calendar-vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neocomplcache'
" Plugin 'Shougo/neocomplete' # if vim ver. 7.3885 is available... go for it
Plugin 'Shougo/vimproc'
Plugin 'Shougo/vimshell'
Plugin 'thinca/vim-quickrun'
Plugin 'c9s/perlomni.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'Lokaltog/vim-powerline'
Plugin 'klen/python-mode'
Plugin 'rcmdnk/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'Townk/vim-autoclose' # imcompatibility with neocomplcache
Plugin 'jiangmiao/auto-pairs'
" Plugin 'tpope/vim-fugitive'
" non github repos
Plugin 'http://git.code.sf.net/p/vim-latex/vim-latex'

call vundle#end()
filetype plugin indent on

" 色テーマ設定
" gvimの色テーマは.gvimrcで指定する
set t_Co=256
set background=light
let g:solarized_termcolors=&t_Co
let g:solarized_termtrans=0
colorscheme solarized


" ---------------- "
"  neocomplecache  "
" ---------------- "

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" ------------------- "
"   Powerline setup   "
" ------------------- "

"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2
let g:Powerline_symbols = 'fancy'

""
"" Vim-LaTeX
""
filetype plugin on
filetype indent on
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
""let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
"let g:Tex_CompileRule_pdf = 'ptex2pdf -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = 'ptex2pdf -l -u -ot "-synctex=1
"-interaction=nonstopmode -file-line-error-style" $*'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode-file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode
"-file-line-error-style $*'
""let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode-file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode
"-file-line-error-style $*'
let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
"let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = 'platex -synctex=1 -interaction=nonstopmode-file-line-error-style $*'
""let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode-file-line-error-style $*'
let g:Tex_BibtexFlavor = 'pbibtex'
"let g:Tex_BibtexFlavor = 'upbibtex'
""let g:Tex_BibtexFlavor = 'bibtex'
"let g:Tex_BibtexFlavor = 'bibtexu'
let g:Tex_MakeIndexFlavor = 'mendex $*.idx'
"let g:Tex_MakeIndexFlavor = 'makeindex $*.idx'
"let g:Tex_MakeIndexFlavor = 'texindy $*.idx'
"let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = 'evince'
""let g:Tex_ViewRule_pdf = 'okular --unique'
"let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n
"--remote-silent +\%{line} \%{input}"'
""let g:Tex_ViewRule_pdf = 'qpdfview --unique'
"let g:Tex_ViewRule_pdf = 'pdfviewer'
""let g:Tex_ViewRule_pdf = 'texworks'
"let g:Tex_ViewRule_pdf = 'mupdf'
""let g:Tex_ViewRule_pdf = 'firefox -new-window'
"let g:Tex_ViewRule_pdf = 'chromium --new-window'
""let g:Tex_ViewRule_pdf = 'acroread'
"let g:Tex_ViewRule_pdf = 'pdfopen -viewer ar9-tab'
"let g:Tex_ViewRule_ps = 'evince'
""let g:Tex_ViewRule_ps = 'okular --unique'
"let g:Tex_ViewRule_ps = 'zathura'
""let g:Tex_ViewRule_ps = 'qpdfview --unique'
"let g:Tex_ViewRule_ps = 'gv --watch'
let g:Tex_ViewRule_dvi = 'pxdvi -watchfile 1'
""let g:Tex_ViewRule_dvi = 'xdvi -watchfile 1'
"----------------------------------------
" time stamp
"---------------------------------------
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%y-%m-%d %a %I:%M %p")<CR>
