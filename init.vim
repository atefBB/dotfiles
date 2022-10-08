" ** Settings **
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set ff=unix

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:javascript_plugin_jsdoc = 1
let NERDTreeShowHidden=1
" Don't show `node_modules` & `.git`  folders
let g:NERDTreeIgnore = ['^node_modules$', '^.git$']
let g:rainbow_active = 1

" Enable AutoSave on Vim startup
let g:auto_save = 1  

" Default values for conflict marker
let g:conflict_marker_begin = '^<<<<<<< \@='
let g:conflict_marker_common_ancestors = '^||||||| .*$'
let g:conflict_marker_separator = '^=======$'
let g:conflict_marker_end   = '^>>>>>>> \@='

" Indenting in ts files
let g:typescript_indent_disable = 1
let g:coc_global_extensions = ['coc-tsserver']

" Enables blamer on startup
let g:blamer_enabled = 1

" The delay in milliseconds for the `git` blame message to show
let g:blamer_delay = 500

set encoding=utf8

set guifont=JetBrainsMono\ Nerd\ Font\ 11

" Open the terminal in `insert mode`
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

" automatically run `import cost` plugin on buffer updates
augroup import_cost_auto_run
  autocmd!
  autocmd InsertLeave *.js,*.jsx,*.ts,*.tsx ImportCost
  autocmd BufEnter *.js,*.jsx,*.ts,*.tsx ImportCost
  autocmd CursorHold *.js,*.jsx,*.ts,*.tsx ImportCost
augroup END

" format on save
augroup neo_format
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" The next 4 lines of config are stollen from `jess archer` nvim config file
" Show me tabs/spaces
set list
set listchars=tab:▸\ ,trail:·

" Enable use of mouse in all modes with a supported terminal"
set mouse=a

" Highlight the line that the cursor is on
set cursorline

" Start vertically scrolling when 3 lines from the top or bottom
set scrolloff=8

" Start horizontally scrolling when 3 lines from the edges
set sidescrolloff=8

" ** Plugins **
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
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'APZelos/blamer.nvim'
Plug 'yardnsm/vim-import-cost', { 'do': 'yarn install' }
call plug#end()

" ** Keys Mapping **
" `Taking note in floaterm` mapping
nnoremap   <silent>   <F7>    :FloatermNew<CR>
nnoremap nte :FloatermNew note<CR>
nnoremap ,df :ALEGoToDefinition<CR>
