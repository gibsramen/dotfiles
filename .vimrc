set nocompatible

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
syntax on

hi Search ctermbg=yellow ctermfg=black cterm=bold
hi IncSearch ctermbg=yellow ctermfg=black
hi Comment ctermfg=green
hi Todo ctermbg=green ctermfg=black
hi MatchParen cterm=bold ctermbg=lightgreen ctermfg=black
hi Number ctermfg=75
hi Debug cterm=bold,underline ctermbg=LightGrey ctermfg=black
hi Pmenu ctermbg=gray

"replace ; with Enter to go forward with t or f
"because ; is already the leader
nnoremap <CR> ;
inoremap jj <Esc>

let mapleader = ";"
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>d :bd<CR>

"command Bd bp\|bd \#
"use to close buffer without closing split
nnoremap ,d :b#<bar>bd#<CR>

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap <leader>tn :tabnew<Space>
nnoremap <leader>tk :tabnext<CR>
nnoremap <leader>tj :tabprev<CR>
nnoremap <leader>th :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>

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

augroup python colorcol
    au FileType python setlocal colorcolumn=80
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

let g:tex_flavor = 'latex'
au BufRead,BufNewFile *.tex setlocal wrap
au BufNewFile,BufRead *.tex nnoremap j gj
au BufNewFile,BufRead *.tex nnoremap k gk
au BufNewFile,BufRead *.tex nnoremap <leader>vc :VimtexCompile<CR>

augroup tex_template
    au BufNewFile *.tex 0put =\"\\documentclass[]{article}\<nl>\"|$
    au BufNewFile *.tex 1put =\"\\begin{document}\<nl>\"|$
    au BufNewFile *.tex 3put =\"\\end{document}\<nl>\"|$
augroup end

au BufNewFile,BufRead Snakefile* set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

au BufReadCmd *.qza,*.qzv call zip#Browse(expand("<amatch>"))

augroup markdown
    autocmd!
    au BufNewFile,BufRead *.md nnoremap j gj
    au BufNewFile,BufRead *.md nnoremap k gk
    au BufNewFile,BufRead *.md setlocal wrap
    au BufNewFile,BufRead *.md nnoremap <silent> <leader>o :!open % <CR><CR>
    au BufNewFile,BufRead *.md setlocal spell
    au BufNewFile,BufRead *.md nnoremap <leader>s 1z=
augroup end

augroup Makefile
    au BufNewFile,BufRead Makefile* setlocal noexpandtab
augroup end

let r_indent_align_args = 0

filetype off
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'gibsramen/vim-delim'
Plug 'jpalardy/vim-slime'
Plug 'eigenfoo/stan-vim'

call plug#end()            " required
filetype plugin indent on    " required

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

map <C-n> :NERDTreeToggle<CR>

let g:limelight_conceal_ctermfg='gray'
nnoremap <leader>ll :Limelight!!<CR>
nnoremap <leader>f :Files<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoC                                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
let g:coc_start_at_startup = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE                                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_set_highlights = 0
let g:airline#extensions#ale#enabled = 0
let g:ale_completion_enabled = 0
let g:ale_linters = {
\    'python': ['flake8'],
\    'latex': [],
\    'javascript': ['jshint']
\}
let g:ale_linters_explicit = 1
"let g:ale_sign_column_always = 1
let g:ale_virtualenv_dir_names = []
nnoremap <leader>an :ALENext<CR>
nnoremap <leader>ap :ALEPrevious<CR>
au FileType python nnoremap <buffer> <leader>af :ALEFix autopep8<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_section_y=$CONDA_DEFAULT_ENV
let g:airline#extensions#tabline#enabled = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimtex                                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimtex_quickfix_ignore_filters = [
      \ 'Font Warning',
      \ 'Underfull',
      \]
let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_latexmk = {'continuous': 0}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF                                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Slime                                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
tnoremap <silent><C-D> <C-D><C-\><C-N>ZQ
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
