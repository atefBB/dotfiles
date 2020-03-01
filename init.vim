set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set ff=unix
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:javascript_plugin_jsdoc = 1
call plug#begin('~/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'StanAngeloff/php.vim'
Plug 'neomake/neomake'
Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
call plug#end()
