execute pathogen#infect()
syntax on

set background=dark
colorscheme solarized

filetype plugin indent on

let mapleader=","
nmap <leader>n :NERDTreeFind<cr>

" TODO: make apply this under ftplugin
nmap <leader>k :call Uncrustify('cpp')<cr>
set shiftwidth=4 tabstop=4
