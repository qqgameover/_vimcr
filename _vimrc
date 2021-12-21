set nocompatible
let &pythonthreedll = 'C:\Users\Kasper\python39.dll'
set encoding=utf-8
set langmenu=en_US.UTF-8
language messages en_US.UTF-8
syntax enable 
set guifont=Hack:s28
let g:ale_completion_enabled=1
set completeopt=longest,menuone,preview
filetype indent plugin on
execute pathogen#infect()
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'https://github.com/tpope/vim-dispatch.git'
Plug 'https://github.com/keremc/asyncomplete-clang.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/powerline/powerline'
Plug 'https://github.com/nickspoons/vim-sharpenup.git'
Plug 'https://github.com/octol/vim-cpp-enhanced-highlight.git'
Plug 'OmniSharp/omnisharp-vim'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'valloric/MatchTagAlways'
Plug 'jiangmiao/auto-pairs'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dense-analysis/ale'
Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/powerline/fonts.git'
Plug 'fatih/vim-go', { 'tag': '*' }
:
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
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

"Ale stuff:
let g:ale_lint_on_enter = 1

let g:ale_linters = { 'cs': ['OmniSharp'], 'cpp': ['clangd']}
" }}}

let g:ale_cpp_clangtidy_checks = []
let g:ale_cpp_clangtidy_executable = 'clang-tidy'
let g:ale_c_parse_compile_commands=1
let g:ale_cpp_clangtidy_extra_options = ''
let g:ale_cpp_clangtidy_options = ''
let g:ale_set_balloons=1
let g:ale_linters_explicit=1
let g:ale_cpp_clangtidy_checks = []
let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

nnoremap <leader>agd :ALEGoToDefinition<cr>
nnoremap <leader>a<space> :ALECodeAction<cr>
nnoremap <leader>as :ALESymbolSearch<cr>
nnoremap <leader>afr :ALEFindReferences<cr>
nnoremap <leader>ah :ALEHover<cr>

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


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
nnoremap <leader>o<space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader>o<space> :call OmniSharp#GetCodeActions('visual')<cr>

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

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

autocmd User asyncomplete_setup call asyncomplete#register_source(
\ asyncomplete#sources#clang#get_source_options())

nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

"powerline stuff
let g:powerline_pycmd = 'py3'
let g:Powerline_symbols='fancy'

source $HOME\.vim\plugged\powerline\powerline\bindings\vim\plugin\powerline.vim
python3 from powerline.vim import setup as powerline_setup;
python3 powerline_setup()

"cpp syntax
let g:cpp_class_scope_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_class_decl_highlight = 1
"let g:cpp_experimental_template_highlight = 1

"general stufferino
set laststatus=2
set t_Co=256
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set autochdir
set background=dark
set number
set relativenumber
set hidden
set cmdheight=4
set updatetime=2000
let c_no_curly_error=1
" Always show tabs
set showtabline=4
colorscheme gruvbox 
