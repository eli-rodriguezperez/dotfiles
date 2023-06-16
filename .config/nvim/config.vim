set nocompatible
set shell=/bin/bash
filetype off
call plug#begin('~/.vim/plugged')
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'sbdchd/neoformat'
Plug 'jiangmiao/auto-pairs'

" Themes
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'chriskempson/base16-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'shaunsingh/solarized.nvim'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'machakann/vim-highlightedyank'

" Utilities
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'norcalli/nvim-colorizer.lua'

" Language syntactic support
Plug 'cakebaker/scss-syntax.vim'
Plug 'jceb/vim-orgmode'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'rust-lang/rust.vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Completion support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
set cmdheight=1
set notimeout ttimeout ttimeoutlen=0 timeoutlen=200
set tabstop=4
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set inccommand=nosplit
set si
set cinoptions+=j1
" Recommended for coc
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Number of lines to keep below the cursor while scrolling
set scrolloff=5

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

" Execute a macro each time in selected lines. (It doesn't stop if it can't
" satisfy the macro).
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the popup menu:
inoremap <expr> <C-l> coc#pum#visible() ? coc#_select_confirm() : coc#refresh()
" inoremap <expr><C-l> (pumvisible()?(empty(v:completed_item)?"\<C-n>\<C-y>":"\<C-y>"):coc#refresh())
" inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

inoremap <expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
"
" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Esc bindings
nnoremap <C-g> <Esc>
inoremap <C-g> <Esc>
vnoremap <C-g> <Esc>
snoremap <C-g> <Esc>
xnoremap <C-g> <Esc>
cnoremap <C-g> <Esc>
onoremap <C-g> <Esc>
lnoremap <C-g> <Esc>
tnoremap <C-g> <Esc>

" Bindings
let mapleader= " "
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nmap <leader>dv :e ~/.config/nvim/config.vim <CR>
nmap <leader>dl :e ~/.config/nvim/init.lua <CR>
nmap <leader>de :e ~/.emacs.d/init.el <CR>
nmap <leader>bd :bd <CR>
nmap <leader><tab> :b# <CR>
nmap <leader>bb :Buffers <CR>
nmap <leader>bs :w<CR>
nmap <leader>wd :close <CR>
nmap <leader>w/ :vsplit <CR>
nmap <leader>w- :split <CR>
nmap <leader>wt :tab sp <CR>
nmap <leader>wc :tabclose <CR>
nmap <leader>pf :Files <CR>
nmap <leader>pg :GFiles <CR>
nmap <leader>ph :History <CR>
nmap <leader>ff :find
nmap <leader>fl :BLines <CR>
nmap <leader>vd :windo diffthis <CR>
nmap <leader>vo :diffoff! <CR>
nmap <leader>sg :Rg <CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap Q @@

" Quick-save

set tags=./tags;tags;

set path+=**

let base16colorspace=256  " Access colors present in 256 colorspace

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

nmap <silent> I <Plug>(coc-codeaction-line)
nmap <silent> W <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Fix completion menu colors
autocmd VimEnter,ColorScheme * hi! link CocMenuSel PMenuSel
autocmd VimEnter,ColorScheme * hi! link CocSearch Identifier

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc#_current_function','')}

let g:clang_exec='/usr/bin/clang'

" Closetag for lit-html buffers
let g:closetag_filetypes = 'html,xhtml,phtml,javascript,typescript'
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion,litHtmlRegion',
      \ 'javascript.jsx': 'jsxRegion,litHtmlRegion',
      \ 'javascript':     'litHtmlRegion',
      \ 'typescript':     'litHtmlRegion',
      \ }

" EditorConfig compatibility
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" Correct indentation inside style tags
let g:html_indent_style1 = "inc"

set termguicolors
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_diagnostic_text_highlight = 1
let g:gruvbox_material_current_word = 'bold'
colorscheme gruvbox-material
set background=dark
hi Normal ctermbg=NONE

