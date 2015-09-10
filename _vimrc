execute pathogen#infect()
syntax on

set background=dark

"this may need to be changed (1 or 0) depending on the terminal emulator in use
let g:solarized_termtrans = 1
colorscheme solarized

filetype plugin indent on

let mapleader=","
nmap <leader>n :NERDTreeFind<cr>

" TODO: make apply this under ftplugin
nmap <leader>k :call Uncrustify('cpp')<cr>
set shiftwidth=4 tabstop=4
