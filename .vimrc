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
set hidden
set backspace=indent,eol,start
syntax on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'gabrielelana/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'davidhalter/jedi-vim'

call vundle#end()
filetype plugin indent on

hi Search ctermbg=yellow ctermfg=black
hi IncSearch ctermbg=yellow ctermfg=black
hi Comment ctermfg=green
hi MatchParen cterm=bold ctermbg=lightgreen ctermfg=black

let mapleader = ";"
nnoremap <leader>n		:bn<CR>
nnoremap <leader>p		:bp<CR>
nnoremap <leader>d		:bd<CR>

nnoremap <C-j>			<C-W>j
nnoremap <C-k>			<C-W>k
nnoremap <C-h>			<C-W>h
nnoremap <C-l>			<C-W>l

nnoremap tn				:tabnew<Space>
nnoremap tk 			:tabnext<CR>
nnoremap tj 			:tabprev<CR>
nnoremap th 			:tabfirst<CR>
nnoremap tl 			:tablast<CR>

nnoremap dl 			0D

nnoremap <leader>h		:noh<CR>

inoremap jj 			<Esc>

augroup octothorpe_comments
	au FileType python,r vnoremap <buffer> #				:norm i#<Esc>
	au FileType python,r vnoremap <buffer> <leader>#		:norm 0x<Esc>

	au FileType python nnoremap <buffer> #				0<C-V>I#<Esc>
	au FileType python nnoremap <buffer> <leader>#		0<C-V>x
augroup end


let g:jedi#usages_command = "<leader>u"
let g:jedi#goto_command = ''
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0

au BufRead,BufNewFile *.py setlocal textwidth=79
augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$
augroup END
map <C-n> :NERDTreeToggle<CR>

let r_indent_align_args = 0
