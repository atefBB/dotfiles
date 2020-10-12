set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set ff=unix
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:javascript_plugin_jsdoc = 1
let NERDTreeShowHidden=1
let g:rainbow_active = 1
let g:auto_save = 1  " enable AutoSave on Vim startup
" Auto format `on save` with `Neoformat`
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END
" Default values for conflict marker
let g:conflict_marker_begin = '^<<<<<<< \@='
let g:conflict_marker_common_ancestors = '^||||||| .*$'
let g:conflict_marker_separator = '^=======$'
let g:conflict_marker_end   = '^>>>>>>> \@='
" Indenting in ts files
let g:typescript_indent_disable = 1
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
Plug 'rhysd/conflict-marker.vim'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
call plug#end()
