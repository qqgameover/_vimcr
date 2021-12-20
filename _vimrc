let &pythonthreedll = 'C:\Users\Kasper\python39.dll'
set encoding=utf-8
set nocompatible
set langmenu=en_US.UTF-8
language messages en_US.UTF-8
let g:powerline_pycmd = 'py3'
set laststatus=2
set t_Co=256
set tabstop=4
set shiftwidth=4
set expandtab
set langmenu=en_US.UTF-8
set autochdir
set background=dark
language messages en_US.UTF-8
set number
set laststatus=2
set relativenumber
set hidden
set cmdheight=4
set updatetime=2000
" Always show tabs
set showtabline=4

set guifont=Source\ Code\ Pro\ Semibold:s28
filetype indent plugin on
syntax enable
set completeopt=longest,menuone,preview

execute pathogen#infect()
source $HOME\.vim\plugged\powerline\powerline\bindings\vim\plugin\powerline.vim
python3 from powerline.vim import setup as powerline_setup;
python3 powerline_setup()

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/junegunn/limelight.vim.git'
Plug 'nickspoons/vim-sharpenup'
Plug 'https://github.com/keremc/asyncomplete-clang.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/powerline/powerline'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'valloric/MatchTagAlways'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dense-analysis/ale'
Plug 'chriskempson/base16-vim'
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/powerline/fonts.git'
Plug 'https://github.com/ycm-core/YouCompleteMe.git'
Plug 'fatih/vim-go', { 'tag': '*' }
:
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'OmniSharp/omnisharp-vim'
Plug 'https://github.com/prabirshrestha/asyncomplete.vim.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '~/my-prototype-plugin'
call plug#end()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
map <C-n> :NERDTreeToggle<CR>
map <C-p> :GFiles<CR>
map <C-f> :Files<CR>
let mapleader = ","

autocmd FileType cs nmap <silent> gd :OmniSharpGotoDefinition<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
autocmd FileType cs nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>

let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'always'

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif


let g:ale_linters = { 'cs': ['OmniSharp'], 'cpp': ['clangtidy'], 'c': ['clangtidy'] }
" }}}

let g:ale_cpp_clangtidy_checks = []
let g:ale_cpp_clangtidy_executable = 'clang-tidy'
let g:ale_c_parse_compile_commands=1
let g:ale_cpp_clangtidy_extra_options = ''
let g:ale_cpp_clangtidy_options = ''
let g:ale_set_balloons=1
let g:ale_linters_explicit=1

" OmniSharp: {{{
let g:OmniSharp_popup_position = 'peek'
if has('nvim')
  let g:OmniSharp_popup_options = {
  \ 'winhl': 'Normal:NormalFloat'
  \}
else
  let g:OmniSharp_popup_options = {
  \ 'highlight': 'Normal',
  \ 'padding': [0, 0, 0, 0],
  \ 'border': [1]
  \}
endif

let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}

let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}
" }}}

autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#clang#get_source_options())

" Remove 'Press Enter to continue' message when type information is longer than one line.

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)

set statusline+=%#warningmsg#
set statusline+=%*
let g:limelight_default_coefficient = 0.8

nnoremap <Leader>l :Limelight 0.8<cr>

nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>
let g:ycm_add_preview_to_completeopt = 1
nmap <leader>D <Plug>(YCMHover)
augroup MyYCMCustom
  autocmd!
  autocmd FileType c,cpp let b:ycm_hover = {
    \ 'command': 'GetDoc',
    \ 'syntax': &filetype
    \ }
augroup END

set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox
