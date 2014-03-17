" Fetch NeoBundle if not available
let neoBundleReadMe=expand('~/.vim/bundle/neobundle.vim/README.md')
if !filereadable(neoBundleReadMe)
  echo "Installing NeoBundle...\n"
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
endif

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
  let g:make = 'make'
endif

" My Bundles here:
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': g:make}}
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/wildfire.vim'
" NeoBundle 'Shougo/neocomplete'
" NeoBundle 'Shougo/neomru.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'ddollar/nerdcommenter'
NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'Valloric/YouCompleteMe', {'build': {'unix': './install.sh --clang-completer'}}
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'freitass/todo.txt-vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'terryma/vim-multiple-cursors'
" NeoBundle 'altercation/vim-colors-solarized'

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


let mapleader = ","


" CtrlP
" Window configurations:
" 	position:bottom
" 	order (of results):top to bottom (ttb)
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_working_path_mode = ''  " working path won't change when opening new files
let g:ctrlp_switch_buffer = 'Et'    " jump to opened window (if any)

" Unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>r :<C-u>Unite -start-insert file_rec/async:!<CR>

let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :<C-u>Unite history/yank<CR>

" NERDCommenter
" Map <C-/> to toggle comment both in normal and visual mode
nmap  <plug>NERDCommenterToggle
vmap  <plug>NERDCommenterToggle

" Tabularize
nmap <silent> <leader>a= :<C-u>Tabularize /=<CR>
vmap <silent> <leader>a= :<C-u>Tabularize /=<CR>
nmap <silent> <leader>a: :<C-u>Tabularize /:<CR>
vmap <silent> <leader>a: :<C-u>Tabularize /:<CR>
nmap <silent> <leader>a:: :<C-u>Tabularize /:\zs<CR>
vmap <silent> <leader>a:: :<C-u>Tabularize /:\zs<CR>
nmap <silent> <leader>a, :<C-u>Tabularize /,<CR>
vmap <silent> <leader>a, :<C-u>Tabularize /,<CR>

" NERDTree
nnoremap <silent> <F8> :NERDTreeToggle<CR>

" Tagbar
let g:tagbar_sort      = 0  " Display tags the same order they appear in the source file
let g:tagbar_width     = 30 " Set Tagbar window width to 30
let g:tagbar_autofocus = 1  " Change the focus to the Tagbar window whenever it is opened
nnoremap <silent> <F9> :TagbarToggle<CR>

" Fugitive
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gp :Git push<CR>
nmap <silent> <leader>gs :Gstatus<CR>


" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Move between windows using ctrl-[hjkl]
nnoremap <silent> <C-K> <C-W>k
nnoremap <silent> <C-J> <C-W>j
nnoremap <silent> <C-H> <C-W>h
nnoremap <silent> <C-L> <C-W>l

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Latex file encoding
autocmd FileType plaintex setlocal fileencoding=utf8

" Appearance
syntax on
set hlsearch
if has("gui_macvim")
  set guifont=Menlo:h12
endif

" Colorscheme
set background=dark
let g:solarized_termtrans=0 " Required by iTerm2
colorscheme rdark

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50                 " keep 50 lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set nobackup                   " Disable the creation of backup files (the ones ending with ~)
set mouse=a                    " enable mouse 'all'
set number                     " line numbers
set scrolloff=4                " Keep the cursor away from top/bottom
set wildmode=longest,list      " TAB completion (such as bash)
set laststatus=2               " Always show a status bar
set smartcase                  " Ignore case when search pattern is all lowercase
set shiftwidth=2               " # of spaces of auto indent
set softtabstop=2              " # of spaces of <TAB> key
set tabstop=2                  " # of spaces erased when deleting a <TAB>
set expandtab                  " Insert spaces instead of tabs
set smarttab                   " 'siftwidth' in front of a line

