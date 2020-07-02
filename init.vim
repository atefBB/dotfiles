set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set ff=unix
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:javascript_plugin_jsdoc = 1
let NERDTreeShowHidden=1
"let g:polyglot_disabled = ['javascript']
let g:rainbow_active = 1
let g:auto_save = 1  " enable AutoSave on Vim startup
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
call plug#begin('~/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
Plug 'StanAngeloff/php.vim'
Plug 'neomake/neomake'
Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-multiple-cursors'
Plug 'sbdchd/neoformat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'vim-scripts/vim-auto-save'
Plug 'itchyny/lightline.vim'
Plug 'https://github.com/stephpy/vim-php-cs-fixer'
Plug 'https://github.com/moll/vim-bbye.git'
Plug 'dense-analysis/ale'
call plug#end()
