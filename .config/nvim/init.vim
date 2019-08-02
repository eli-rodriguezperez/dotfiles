set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'sbdchd/neoformat'

" Themes
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'machakann/vim-highlightedyank'

" Utilities
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'

" Language syntactic support
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'jceb/vim-orgmode'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'rust-lang/rust.vim'

" Completion support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'roxma/nvim-yarp'
call plug#end()

filetype indent plugin on
syntax on
set cursorline
set nobackup
set nowritebackup
set noswapfile
set hidden
set wildmenu
set wildmode=longest,full
set showcmd
set hlsearch
set incsearch
set linebreak
set nomodeline
set ignorecase
set smartcase
set encoding=utf-8
set backspace=indent,eol,start
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set ttyfast
set lazyredraw
set synmaxcol=500
set mouse=a
set cmdheight=2
set notimeout ttimeout ttimeoutlen=0 timeoutlen=200
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set inccommand=nosplit
set si
set cinoptions+=j1
set t_Co=256
colorscheme solarized
set background=dark
" Recommended for coc
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Permanent undo
set undodir=~/.vimdid
set undofile

"Create function that feeds <down> when pressing <C-l> 
function! EnterSubdir()
  call feedkeys("\<Down>", 't')
  return ''
endfunction
cnoremap <expr> <C-l> EnterSubdir()

"Set relativenumber on focused doc
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the popup menu:
inoremap <expr><C-l> (pumvisible()?(empty(v:completed_item)?"\<C-n>\<C-y>":"\<C-y>"):"\<C-l>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Bindings
let mapleader= " "
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nmap <leader>dv :e ~/.config/nvim/init.vim <CR>
nmap <leader>de :e ~/.emacs.d/init.el <CR>
nmap <leader>bd :bd <CR>
nmap <leader><tab> :b# <CR>
nmap <leader>bb :Buffers <CR>
nmap <leader>bs :w<CR>
nmap <leader>wd :close <CR>
nmap <leader>w- :vsplit <CR>
nmap <leader>w/ :split <CR>
nmap <leader>wt :tab sp <CR>
nmap <leader>wc :tabclose <CR>
nmap <leader>pf :Files <CR>
nmap <leader>ff :find
nmap <leader>sg :Rg <CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Q @@

" Quick-save

set tags=./tags;tags;

set path+=**

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = { 'colorscheme': 'solarized', }

if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Linter
" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'all_targets': 1,
		\ 'build_on_save': 1,
		\ 'clippy_preference': 'on'
	\ }
	\ }
let g:ale_rust_rls_toolchain = ''
let g:ale_linters = {'rust': ['rls'], 'javascript': ['eslint']}
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_fix_on_save = 1

let g:clang_exec='/usr/bin/clang'

"Closetag for lit-html buffers
let g:closetag_filetypes = 'html,xhtml,phtml,javascript,typescript'
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion,litHtmlRegion',
      \ 'javascript.jsx': 'jsxRegion,litHtmlRegion',
      \ 'javascript':     'litHtmlRegion',
      \ 'typescript':     'litHtmlRegion',
      \ }
