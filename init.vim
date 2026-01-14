" =========================================================
" Basic settings
" =========================================================
set nocompatible
set encoding=utf8
set fileformats=unix,dos
set ff=unix
set mouse=a
set scrolloff=8
set sidescrolloff=8
set statusline=%f

" Prevent CRLF issues
autocmd BufWritePre * set fileformat=unix

" =========================================================
" Runtime (keep if you still use ~/.vimrc)
" =========================================================
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
if filereadable(expand("~/.vimrc"))
  source ~/.vimrc
endif

" =========================================================
" NERDTree
" =========================================================
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['^node_modules$', '^\.git$']

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" =========================================================
" Plugins settings
" =========================================================
let g:rainbow_active = 1
let g:typescript_indent_disable = 1

" ALE (no LSP features)
let g:ale_hover_to_floating_preview = 0
let g:ale_set_balloons = 0

" Floaterm
let g:floaterm_height = 0.95
let g:floaterm_width  = 0.8

" =========================================================
" PHP CS Fixer (disable Neoformat for PHP to avoid double runs)
" =========================================================
let g:neoformat_enabled_php = []
let g:php_cs_fixer_path = 'php-cs-fixer'
let g:php_cs_fixer_config = '.php-cs-fixer.php'
let g:php_cs_fixer_rules = '@PSR12'
let g:php_cs_fixer_allow_risky = 1
let g:php_cs_fixer_cache = '.php-cs-fixer.cache'

" prettier to format blade files
let g:neoformat_enabled_blade = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_javascript = ['prettier']

" `blade-formatter` should be installed on the system
let g:neoformat_blade_bladeformatter = {
      \ 'exe': 'blade-formatter',
      \ 'args': ['--write', '%:p'],
      \ 'stdin': 0,
      \ }
let g:neoformat_enabled_blade = ['bladeformatter']

" php-cs-fixer fix on save
autocmd BufWritePost *.php silent! !php-cs-fixer fix % 

" Auto-detect Blade filetype
autocmd BufRead,BufNewFile *.blade.php set filetype=blade

" =========================================================
" Ignore files
" =========================================================
set wildignore+=*/vendor/*,*/storage/*
let g:far#ignore_files = ['vendor/*', 'storage/*', '.git/*']

" =========================================================
" Lightline (gitbranch plugin)
" =========================================================
let g:lightline = {
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'gitbranch', 'readonly', 'filename', 'modified' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ }
      \ }

" =========================================================
" Terminal behavior
" =========================================================
autocmd TermOpen * startinsert

" =========================================================
" Import cost
" =========================================================
augroup import_cost_auto_run
  autocmd!
  autocmd BufEnter,InsertLeave,CursorHold *.js,*.jsx,*.ts,*.tsx ImportCost
augroup END

" =========================================================
" Neoformat (exclude PHP)
" =========================================================
augroup neo_format
  autocmd!
  autocmd BufWritePre *
        \ if index(['php', 'blade'], &filetype) < 0 |
        \   undojoin | Neoformat |
        \ endif
augroup END

" =========================================================
" Plugins
" =========================================================
call plug#begin('~/nvim/plugged')
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
Plug 'frazrepo/vim-rainbow'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug 'rhysd/conflict-marker.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'dracula/vim'
Plug 'voldikss/vim-floaterm'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'APZelos/blamer.nvim'
Plug 'yardnsm/vim-import-cost', { 'do': 'yarn install' }
Plug 'tpope/vim-commentary'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/vim-gitbranch'
"Plug 'phpactor/phpactor', { 'do': 'composer install' }
Plug 'stephpy/vim-php-cs-fixer'
call plug#end()

" =========================================================
" Key mappings
" =========================================================
nnoremap <silent> <F7> :FloatermNew<CR>
nnoremap <leader>df :ALEGoToDefinition<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" CoC navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Docs
nnoremap <silent> K :call ShowDocumentation()<CR>

" Disable ^
nnoremap ^ <Nop>
vnoremap ^ <Nop>
onoremap ^ <Nop>

" =========================================================
" Functions
" =========================================================
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
