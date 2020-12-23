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
set expandtab
"set t_Co=256
set laststatus=2
set nofoldenable
set hidden
set backspace=indent,eol,start
set splitbelow
set splitright
set list listchars=tab:\|_,trail:▩,extends:>
set is!
syntax on

hi Search ctermbg=yellow ctermfg=black cterm=bold
hi IncSearch ctermbg=yellow ctermfg=black
hi Comment ctermfg=green
hi Todo ctermbg=green ctermfg=black
hi MatchParen cterm=bold ctermbg=lightgreen ctermfg=black
hi Number ctermfg=75
hi Debug cterm=bold,underline ctermbg=LightGrey ctermfg=black
hi Pmenu ctermbg=darkgray

"replace ; with Enter to go forward with t or f
"because ; is already the leader
nnoremap <CR> ;
inoremap jj <Esc>

let mapleader = ";"
nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bd :bd<CR>

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
nnoremap <leader>h :nohlsearch<CR>
nnoremap Y y$

let g:is_bash = 1

augroup octothorpe_comments
    autocmd!
    au FileType python,r vnoremap <buffer> ## :norm i#<Esc>
    au FileType python,r vnoremap <buffer> <leader>## :norm 0x<Esc>

    au FileType python nnoremap <buffer> ## 0<C-V>I#<Esc>
    au FileType python nnoremap <buffer> <leader>## 0<C-V>x
augroup end

augroup python
    " Move to previous and next function (def) or class (class)
    autocmd!
    au FileType python nnoremap <buffer> [f ?def\ <CR>:noh<CR>
    au FileType python nnoremap <buffer> ]f /def\ <CR>:noh<CR>
    au FileType python nnoremap <buffer> [c ?class\ <CR>:noh<CR>
    au FileType python nnoremap <buffer> ]c /class\ <CR>:noh<CR>

    highlight ColorColumn ctermbg=lightgray
    au FileType python setlocal colorcolumn=80
    au BufRead,BufNewFile *.py setlocal textwidth=79
augroup end

let g:tex_flavor = 'latex'
augroup latex
    au BufRead,BufNewFile *.tex setlocal wrap
    au BufNewFile,BufRead *.tex nnoremap j gj
    au BufNewFile,BufRead *.tex nnoremap k gk
    au BufNewFile,BufRead *.tex nnoremap <leader>vc :VimtexCompile<CR>
    au BufNewFile *.tex 0put =\"\\documentclass[]{article}\<nl>\"|$
    au BufNewFile *.tex 1put =\"\\begin{document}\<nl>\"|$
    au BufNewFile *.tex 3put =\"\\end{document}\<nl>\"|$
augroup end

au BufNewFile,BufRead Snakefile* set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

au BufNewFile,BufRead *.json set tabstop=2
au BufNewFile,BufRead *.json set shiftwidth=2

au BufNewFile,BufRead *.js set shiftwidth=4

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

"https://vi.stackexchange.com/questions/18454/how-to-know-which-highlighting-group-is-used-for-the-background-of-a-word
command SynID  echo synIDattr(synID(line("."), col("."), 1), "name")

filetype off
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'maxmellon/vim-jsx-pretty'
Plug 'yuezk/vim-js'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'
"Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for some reason git commit file editing causes an error
let g:coc_disable_startup_warning = 1

highlight CocErrorFloat ctermbg=None ctermfg=darkred cterm=bold
highlight CocErrorSign ctermbg=red ctermfg=black
highlight CocErrorVirtualText ctermbg=None ctermfg=red cterm=bold

highlight CocWarningFloat ctermbg=None ctermfg=yellow cterm=bold
highlight CocWarningSign ctermbg=yellow ctermfg=black
highlight CocWarningVirtualText ctermbg=None ctermfg=yellow cterm=bold

highlight CocInfoFloat ctermbg=None ctermfg=gray cterm=bold
highlight CocInfoSign ctermbg=gray ctermfg=black
highlight CocInfoVirtualText ctermbg=None ctermfg=gray cterm=bold

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
"
"https://github.com/neoclide/coc-python/issues/55#issuecomment-617499047
if $CONDA_PREFIX == ""
  let s:current_python_path=$CONDA_PYTHON_EXE
else
  let s:current_python_path=$CONDA_PREFIX.'/bin/python'
endif
call coc#config('python', {'pythonPath': s:current_python_path})

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

"https://github.com/neoclide/coc.nvim/issues/64#issuecomment-662102899
try
    nmap <silent> ]c :call CocAction('diagnosticNext')<cr>
    nmap <silent> [c :call CocAction('diagnosticPrevious')<cr>
endtry

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:ale_set_highlights = 0
"highlight ALEError ctermfg=red cterm=bold
"highlight ALEErrorSign ctermbg=red ctermfg=black
"highlight ALEWarning ctermfg=yellow cterm=bold
"highlight ALEWarningSign ctermbg=yellow ctermfg=black
"highlight ALEInfo ctermfg=cyan
"highlight ALEInfoSign ctermbg=cyan ctermfg=white
"
"let g:ale_virtualtext_cursor = 1
"let g:ale_virtualtext_prefix = ">> "
"let g:airline#extensions#ale#enabled = 0
"let g:ale_completion_enabled = 0
"let g:ale_linters = {
"\    'python': ['flake8'],
"\    'latex': [],
"\    'javascript': ['jshint']
"\}
"let g:ale_linters_explicit = 1
""let g:ale_sign_column_always = 1
"let g:ale_virtualenv_dir_names = []
"nnoremap <leader>an :ALENext<CR>
"nnoremap <leader>ap :ALEPrevious<CR>
"au FileType python nnoremap <buffer> <leader>af :ALEFix autopep8<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_section_y=$CONDA_DEFAULT_ENV
let g:airline#extensions#tabline#enabled = 1
" remove interpreter from statusline
let g:airline#extensions#coc#enabled = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimtex
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vimtex_quickfix_ignore_filters = [
      \ 'Font Warning',
      \ 'Underfull',
      \]
let g:vimtex_view_method = 'skim'
let g:vimtex_compiler_latexmk = {'continuous': 0}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Slime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:slime_target = "tmux"
" use Ctrl-b + q to see pane numbers
" use :.1 for i.e. pane 1
tnoremap <silent><C-D> <C-D><C-\><C-N>ZQ


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-jsx-pretty
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi jsxCloseString ctermbg=None ctermfg=214
hi link jsxTagName jsxCloseString
hi jsxComponentName ctermbg=None ctermfg=214 cterm=bold
