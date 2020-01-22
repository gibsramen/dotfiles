set nocompatible
filetype off

set cursorline
set foldmethod=indent
set foldlevel=99
set hlsearch
set wildmenu
set ignorecase
set ruler
set showcmd
set number
set relativenumber
set background=dark
set visualbell
set nowrap
set showmode
set autoindent
set tabstop=4
set shiftwidth=4
"set noexpandtab
set expandtab
set t_Co=256
set laststatus=2
set nofoldenable
set hidden
set backspace=indent,eol,start
set splitbelow
set splitright
set list listchars=tab:\|_,trail:▩,extends:>
set iskeyword-=_
syntax on

hi Search ctermbg=yellow ctermfg=black
hi IncSearch ctermbg=yellow ctermfg=black
hi Comment ctermfg=green
hi Todo ctermbg=green ctermfg=black
hi MatchParen cterm=bold ctermbg=lightgreen ctermfg=black
hi Number ctermfg=75

inoremap jj <Esc>

let mapleader = ";"
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>d :bd<CR>

command Bd bp\|bd \#

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap th :tabfirst<CR>
nnoremap tl :tablast<CR>

nnoremap dl 0D
nnoremap <leader>h :noh<CR>
nnoremap Y y$

augroup octothorpe_comments
    autocmd!
	au FileType python,r vnoremap <buffer> ## :norm i#<Esc>
	au FileType python,r vnoremap <buffer> <leader>## :norm 0x<Esc>

	au FileType python nnoremap <buffer> ## 0<C-V>I#<Esc>
	au FileType python nnoremap <buffer> <leader>## 0<C-V>x
augroup end

augroup python_movement
    " Move to previous and next function (def) or class (class)
    autocmd!
    au FileType python nnoremap <buffer> [f ?def\ <CR>:noh<CR>
    au FileType python nnoremap <buffer> ]f /def\ <CR>:noh<CR>
    au FileType python nnoremap <buffer> [c ?class\ <CR>:noh<CR>
    au FileType python nnoremap <buffer> ]c /class\ <CR>:noh<CR>
augroup end

au BufRead,BufNewFile *.py setlocal textwidth=79
augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$
augroup END

au BufRead,BufNewFile *.tex setlocal wrap

au BufNewFile,BufRead Snakefile* set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

augroup markdown
    autocmd!
    au BufNewFile,BufRead *.md nnoremap j gj
    au BufNewFile,BufRead *.md nnoremap k gk
    au BufNewFile,BufRead *.md setlocal wrap
    au BufNewFile,BufRead *.md nnoremap <leader>o :!open %<CR>
augroup end

let r_indent_align_args = 0

let g:ale_completion_enabled = 1
"let g:ale_linters = {'python': ['flake8', 'mypy', 'pylint', 'pyls']}
let g:ale_linters = {'python': ['flake8']}
let g:vimtex_view_method = 'skim'
let g:ale_virtualenv_dir_names = []
"let g:ale_sign_column_always = 1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'lervag/vimtex'
Plugin 'dense-analysis/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'gibsramen/vim-delim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

map <C-n> :NERDTreeToggle<CR>
nnoremap <leader>an :ALENext<CR>
nnoremap <leader>ap :ALEPrevious<CR>
au FileType python nnoremap <buffer> <leader>af :ALEFix autopep8<CR>

"vim-airline

let x=$CONDA_DEFAULT_ENV
let g:airline_section_y=$CONDA_DEFAULT_ENV
"let g:airline_section_b="%{airline#util#wrap(airline#extensions#branch#get_head(),80)}"
"let g:airline_section_x="%<%<%{airline#extensions#fugitiveline#bufname()}%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#"
"let g:airline_section_y = ''
"let g:airline_section_z = ''

au BufReadCmd *.qza,*.qzv call zip#Browse(expand("<amatch>"))
