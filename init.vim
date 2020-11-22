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
" Default values for conflict marker
let g:conflict_marker_begin = '^<<<<<<< \@='
let g:conflict_marker_common_ancestors = '^||||||| .*$'
let g:conflict_marker_separator = '^=======$'
let g:conflict_marker_end   = '^>>>>>>> \@='
" Indenting in ts files
let g:typescript_indent_disable = 1
call plug#begin('~/nvim/plugged')
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'vim-scripts/vim-auto-save'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'rhysd/conflict-marker.vim'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'dracula/vim'
Plug 'voldikss/vim-floaterm'
call plug#end()
set guifont=JetBrainsMono\ Nerd\ Font\ 11

nnoremap nte :FloatermNew note<CR>
