set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged')
Plugin 'VundleVim/Vundle.vim'
Plugin 'sjl/badwolf'
Plugin 'flazz/vim-colorschemes'
Plugin 'bling/vim-airline'
call vundle#end()
filetype indent plugin on
syntax on
set cursorline
set hidden
set wildmenu
set showcmd
set hlsearch
set incsearch
set nomodeline
set ignorecase
set smartcase
set encoding=utf-8
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set mouse=a
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set shiftwidth=4
set softtabstop=4
set expandtab
set t_Co=256
colorscheme molokai
set background=dark
"Disable vim theme background
hi Normal ctermbg=none
"Set 'Visual mode' selection background color
hi Visual ctermbg=darkgrey
"Set relativenumber on focused doc
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
"
