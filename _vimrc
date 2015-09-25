execute pathogen#infect()
syntax on

set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

"this may need to be changed (1 or 0) depending on the terminal emulator in use
let g:solarized_termtrans = 1
colorscheme solarized

filetype plugin indent on

" Split Navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

"Nerd-tree

let mapleader=","
nmap <leader>n :NERDTreeFind<cr>

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
