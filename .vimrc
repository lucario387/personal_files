" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.1

if &compatible
  finish
else
  let g:loaded_sensible = 1
endif

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif

if &shell =~# 'fish$'
  set shell=/bin/zsh
endif

set autoread
set fileformats+=mac

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" Leader
let mapleader = " "

" Options
" set paste
set ruler
set expandtab 
set smarttab 
set splitright
set splitbelow
set wrap linebreak 
set smartindent 
set clipboard^=unnamedplus
set shiftwidth=2 
set tabstop=8
set softtabstop=2
set conceallevel=2

" Mappings
inoremap <C-H> <Left>
inoremap <C-C> <Esc>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
inoremap <C-F> <C-Right>
inoremap <C-B> <C-Left>
inoremap <C-E> <End>
inoremap <C-A> <Esc>^i
inoremap <A-j> <Esc>:m+1<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi

vnoremap <Leader>y "+y
vnoremap <leader>Y "+Y
vnoremap <leader>p "+p
vnoremap <leader>P "+P

xnoremap < <gv
xnoremap > >gv
xnoremap <A-j> :m'>+1<CR>gv=gv
xnoremap <A-k> :m'<-2<CR>gv=gv
xnoremap p p:let @+=@0<CR>:let @"=@0<CR>
xnoremap <expr> j v:count <Bar><Bar> mode(1)[0:1] == "no" ? "j" : "gj"
xnoremap <expr> k v:count <Bar><Bar> mode(1)[0:1] == "no" ? "k" : "gk"


nnoremap x "_x
nnoremap <C-C> :%y+<CR>
nnoremap <C-S> :w<CR>
nnoremap <C-D> <C-D>zz
nnoremap <C-U> <C-u>zz
nnoremap n nzz
nnoremap <expr> j v:count <Bar><Bar> mode(1)[0:1] == "no" ? "j" : "gj"
nnoremap <expr> k v:count <Bar><Bar> mode(1)[0:1] == "no" ? "k" : "gk"
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <A-k> :m -2<CR>==
nnoremap <A-j> :m +1<CR>==
nnoremap <Leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap <leader>q :q<CR>
set whichwrap+=<,>,[,],h,l

