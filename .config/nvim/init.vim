set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged')
Plugin 'VundleVim/Vundle.vim'
Plugin 'docunext/closetag.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'sbdchd/neoformat'

" Themes
Plugin 'joshdick/onedark.vim'
Plugin 'dracula/vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'itchyny/lightline.vim'
Plugin 'altercation/vim-colors-solarized'

" Language syntactic support
Plugin 'sheerun/vim-polyglot'
Plugin 'jceb/vim-orgmode'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'pangloss/vim-javascript'

" Completion support
Plugin 'ncm2/ncm2'
Plugin 'roxma/nvim-yarp'

" Completion plugins
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-tmux'
Plugin 'ncm2/ncm2-path'
call vundle#end()
filetype indent plugin on
syntax on
set cursorline
set nobackup
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
set mouse=a
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set si
set cinoptions+=j1
set t_Co=256
colorscheme solarized
set background=dark
"Disable vim theme background
hi Normal ctermbg=none
"Set 'Visual mode' selection background color
hi Visual ctermbg=darkgrey

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

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

inoremap <expr><C-l> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<C-l>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")
" Use <TAB> to select the popup menu:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Bindings
let mapleader= " "
nmap <leader>dv :e ~/.config/nvim/init.vim <CR>
nmap <leader>de :e ~/.emacs.d/init.el <CR>
nmap <leader>bd :bd <CR>
nmap <leader><tab> :b# <CR>
nmap <leader>bb :CtrlPBuffer <CR>
nmap <leader>wd :close <CR>
nmap <leader>wv :vsplit <CR>
nmap <leader>wh :split <CR>
nmap <leader>wt :tab sp <CR>
nmap <leader>wc :tabclose <CR>
nmap <leader>pf :CtrlP <CR>
nmap <leader>ff :find
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

set tags=./tags;tags;

set path=.,,**

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = { 'colorscheme': 'solarized', }
