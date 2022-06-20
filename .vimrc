set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'preservim/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mhinz/vim-startify'
"Plugin 'frazrepo/vim-rainbow'
"Plugin 'davidhalter/jedi-vim'
"Keep Plugin commands between vundle#begin/end.
"Plugin from github, format: Plugin 'username/repo'

call vundle#end()              

" required
filetype plugin indent on      
"let g:jedi#auto_initialization = 0"
autocmd FileType python setlocal completeopt-=preview

packadd! dracula
syntax enable
colorscheme dracula


"config of nerdtree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>


"config of vim-rainbow
"au FileType c,cpp,objc,objcpp call rainbow#load()
"let g:rainbow_active = 1

set number
set showmatch 
map <C-U> <C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E>
set whichwrap+=<,>,h,l
set scrolloff=3
"set clipboard+=unnamed
set matchtime=1
set tabstop=4
set shiftwidth=4
"set autoindent
set ignorecase
set smartindent
set hlsearch
set cursorline

" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile


"config of statusline
set laststatus=2
set statusline=%{b:gitbranch}
set statusline+=%F%m%r%h%w\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

syntax on
filetype on
autocmd FileType python set tabstop=4 | set expandtab | set autoindent 


map <S-m> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -std=c++11 -o %<"
		exec "!time ./%<"
		exec "!rm %<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python3 %"
	endif
endfunc

"代码格式优化化

map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc

"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python") "这里要验证
        call append(line("."),"# coding=utf-8")
	    call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
	    call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."),   "	> File Name: ".expand("%")) 
		call append(line(".")+1, "    > Full Path: ".expand("%:p"))
		call append(line(".")+2, "	> Author: Hang Zhang") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "#include<algorithm>")
		call append(line(".")+8, "#include<cstdlib>")
		call append(line(".")+9, "#include<cstring>")
		call append(line(".")+10, "#include<cstdio>")
		call append(line(".")+11, "#include<stack>")
		call append(line(".")+12, "#include<string>")
		call append(line(".")+13, "#include<queue>")
		call append(line(".")+14, "#include<set>")
		call append(line(".")+15, "#include<map>")
		call append(line(".")+16, "#include<cmath>")
		call append(line(".")+17, "#include<fstream>")
		call append(line(".")+18, "using namespace std;")
		call append(line(".")+19, "typedef long long ll;")
		call append(line(".")+20, "const int MAXN=200005;")
		call append(line(".")+21, "const ll mod=1e9+7;")
		call append(line(".")+22, "const int inf=0x3f3f3f3f;")
		call append(line(".")+23, "")
		call append(line(".")+24, "")
		call append(line(".")+25, "")
		call append(line(".")+26, "")
		call append(line(".")+27, "")
		call append(line(".")+28, "")
		call append(line(".")+29, "")
		call append(line(".")+30, "")
		call append(line(".")+31, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	endif
endfunc 
autocmd BufNewFile * normal G


"nnoremap p <S-p>
"inoremap ' ''<ESC>i
"inoremap " ""<ESC>i
"inoremap ( ()<ESC>i
"inoremap [ []<ESC>i
"inoremap { {<CR>}<ESC>O



"hi Comment ctermfg =6
"hi String ctermfg =yellow
hi Type ctermfg =yellow
hi Normal ctermfg=252 ctermbg=none
