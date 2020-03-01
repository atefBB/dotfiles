set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set ff=unix
call plug#begin('~/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'StanAngeloff/php.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'neomake/neomake'
Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'preservim/nerdtree'
call plug#end()
