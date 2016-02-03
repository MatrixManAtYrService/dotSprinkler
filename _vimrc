" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

execute pathogen#infect()
syntax on

set bg=dark
set cursorline cursorcolumn
set colorcolumn=120

" Don't beep
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

" this may need to be changed (1 or 0) depending on the terminal emulator in use
let g:solarized_termtrans = 1
colorscheme solarized

" Spacing stuff
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2

" Fix Cygwin Cursor
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Fix Python Path (for YCM)
let g:ycm_path_to_python_interpreter="/usr/bin/python"
let g:ycm_confirm_extra_conf = 0

" Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

let mapleader=","

" Nerd-tree
nmap <leader>n :NERDTreeFind<cr>
let g:NERDTreeMapOpenSplit='s'
let g:NERDTreeMapOpenVSplit='v'

" Screen (vim + gnu screen)

"let g:ScreenImpl = 'Tmux'

function! GoScreenShell()
	if g:ScreenShellActive
		let line=getline('.')
		:call g:ScreenShellSend(line)
	else
		:ScreenShell
	endif
endfunction

command! -nargs=+ -complete=file ScreenShellCmd call g:ScreenShellSend("<args>")
nmap <leader>sc :ScreenShellCmd<space>

nmap <leader>ss :call GoScreenShell()<cr>
nmap <leader>sv :ScreenShell!<cr>
vmap <leader>ss :ScreenSend<cr>
nmap <leader>sq :ScreenQuit<cr>
map <leader>s<tab> :call g:ScreenShellFocus()<cr>

" TODO: make apply this under ftplugin
nmap <leader>k :call Uncrustify('cpp')<cr>
