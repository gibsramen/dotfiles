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
set noexpandtab
set t_Co=256
set laststatus=2
set nofoldenable
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'gabrielelana/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on

hi Search ctermbg=yellow ctermfg=black
hi IncSearch ctermbg=yellow ctermfg=black
hi Comment ctermfg=green

let mapleader = ";"
nnoremap <leader>n	:bn<CR>
nnoremap <leader>p	:bp<CR>
nnoremap <leader>d	:bd<CR>

nnoremap <C-j>	<C-W>j
nnoremap <C-k>	<C-W>k
nnoremap <C-h>	<C-W>h
nnoremap <C-l>	<C-W>l

nnoremap tn		:tabnew<Space>
nnoremap tk 	:tabnext<CR>
nnoremap tj 	:tabprev<CR>
nnoremap th 	:tabfirst<CR>
nnoremap tl 	:tablast<CR>

nnoremap dl 	ddO<Esc>
nnoremap #		0<C-V>I#<Esc>

inoremap jj 	<Esc>

vnoremap #		:norm i#<Esc>

au BufRead,BufNewFile *.py setlocal textwidth=79
augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$
augroup END
map <C-n> :NERDTreeToggle<CR>

let r_indent_align_args = 0
