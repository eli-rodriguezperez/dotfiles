set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged')
Plugin 'VundleVim/Vundle.vim'
Plugin 'docunext/closetag.vim'
Plugin 'ervandew/eclim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'junegunn/fzf'
Plugin 'tpope/vim-fugitive'
Plugin 'sheerun/vim-polyglot'
Plugin 'junegunn/goyo.vim'
Plugin 'uncrustify/uncrustify'
Plugin 'sbdchd/neoformat'
Plugin 'joshdick/onedark.vim'
Plugin 'sjl/badwolf'
Plugin 'dracula/vim'
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
set autoindent
set si
set cinoptions+=j1
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
function! ProseMode()
    call goyo#execute(0, [])
    set spell noci nosi noai nolist noshowmode noshowcmd
    set complete+=s
    set bg=light
    if !has('gui_running')
        let g:solarized_termcolors=256
    endif
    colors solarized
endfunction

command! ProseMode call ProseMode()
