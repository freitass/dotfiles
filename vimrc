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
call neobundle#begin(expand('~/.vim/bundle/'))

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
NeoBundle 'Shougo/vimproc.vim',
      \ {
      \   'build': {
      \     'mac'  : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \   },
      \ }
" NeoBundle 'Shougo/vimshell.vim'
" NeoBundle 'Shougo/neocomplete'
" NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'hewes/unite-gtags'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'ddollar/nerdcommenter'
NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'Valloric/YouCompleteMe',
"       \ {
"       \   'build': {
"       \     'unix' : './install.sh --clang-completer',
"       \     'mac'  : './install.sh --clang-completer'
"       \   }
"       \ }
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'freitass/todo.txt-vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'terryma/vim-multiple-cursors'
" NeoBundle 'altercation/vim-colors-solarized'
" NeoBundle 'vim-scripts/cscope.vim'
" NeoBundle 'scrooloose/syntastic'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'rhysd/vim-clang-format'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'gcmt/wildfire.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


let mapleader = ","


" CtrlP
" if executable('ag')
"   let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
"         \ --ignore .git
"         \ --ignore .svn
"         \ --ignore .hg
"         \ --ignore .settings
"         \ --ignore .project
"         \ --ignore .cproject
"         \ --ignore .DS_Store
"         \ --ignore "**/*.pyc"
"         \ --ignore "**/*.exe"
"         \ --ignore "**/*.pdf"
"         \ --ignore "**/*.so"
"         \ --ignore "**/*.png"
"         \ --ignore "**/*.jpeg"
"         \ --ignore "**/*.dll"
"         \ --ignore "**/*.lib"
"         \ --ignore "**/*.o"
"         \ --ignore "**/*.a"
"         \ --ignore "**/*.dex"
"         \ --ignore "**/*.class"
"         \ --ignore "**/*.bin"
"         \ --ignore "**/*.db"
"         \ --ignore "**/*.bmp"
"         \ --ignore "**/*.apk"
"         \ --ignore "**/*.zip"
"         \ --ignore "**/*.tar"
"         \ --ignore "**/*.tar.bz"
"         \ --ignore "**/*.tar.bz2"
"         \ --ignore "**/*.tar.gz"
"         \ --ignore "**/*.tar.xz"
"         \ --ignore "**/*.tar.lzma"
"         \ --ignore "**/*.rar"
"         \ --ignore "**/*.db"
"         \ --ignore "**/*.d"
"         \ -g ""'
" endif
" Window configurations:
" 	position:bottom
" 	order (of results):top to bottom (ttb)
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_working_path_mode = ''  " working path won't change when opening new files
let g:ctrlp_switch_buffer = 'Et'    " jump to opened window (if any)

" Unite
nnoremap [unite] <Nop>
nmap <space> [unite]

call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Start insert mode in unite-action buffer.
call unite#custom#profile('action', 'context', {
      \   'start_insert' : 1,
      \   'smartcase' : 1
      \ })

nnoremap [unite]f :<C-u>Unite -start-insert file_rec/async:!<CR>


" Unite: unite-source-history/yank
let g:unite_source_history_yank_enable = 1
nnoremap [unite]y :<C-u>Unite history/yank<CR>

" Unite: neosnippet-unite-source-neosnippet
nnoremap [unite]s :<C-u>Unite neosnippet<CR>

" Unite: unite-source-grep
let g:unite_source_grep_max_candidates = 200
if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
  " Use pt in unite grep source.
  " https://github.com/monochromegane/the_platinum_searcher
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '-i --nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
  " Use ack in unite grep source.
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts =
        \ '-i --no-heading --no-color -k -H'
  let g:unite_source_grep_recursive_opt = ''
endif
nnoremap [unite]ug :<C-u>Unite grep:.:-iIR:<CR>

" Unite-gtags
" let g:unite_source_gtags_project_config = {
"       \ '_': { 'treelize': 1 }
"       \ }
" specify your project path as key.
" '_' in key means default configuration.
nnoremap [unite]gx :<C-u>Unite gtags/context<CR>
nnoremap [unite]gr :<C-u>Unite gtags/ref<CR>
nnoremap [unite]gd :<C-u>Unite gtags/def<CR>
nnoremap [unite]gg :<C-u>Unite gtags/grep<CR>
nnoremap [unite]gc :<C-u>Unite gtags/completion<CR>

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
set diffopt=filler,vertical
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gp :Git push<CR>
nmap <silent> <leader>gs :Gstatus<CR>

" YouCompleteMe
" let g:clang_library_path = '/home/likewise-open/CERTI/llf/.vim/bundle/YouCompleteMe/third_party/ycmd'
" let g:clang_use_library=1
" let g:ycm_extra_conf_globlist = ['~/ProjectsRemote/*','!~/*']

" clang-format
" style_options: http://clang.llvm.org/docs/ClangFormatStyleOptions.html
let g:clang_format#command = "clang-format-3.5"
let g:clang_format#code_style = "google"
let g:clang_format#style_options = {
  \ "AccessModifierOffset" : -1,
  \ "AlwaysBreakTemplateDeclarations" : "true",
  \ "Standard" : "C++03"}
" \ "UseTab" : "ForIndentation"}
" \ "SpaceAfterCStyleCast" : "true",

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)

" a.vim
map <silent> <C-Tab> :A<CR>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif


" neocomplete
" Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" " Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" " Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"       \ 'default' : '',
"       \ 'vimshell' : $HOME.'/.vimshell_hist',
"       \ 'scheme' : $HOME.'/.gosh_completions'
"       \ }

" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"   let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" " Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" " Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return neocomplete#close_popup() . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()
" " Close popup by <Space>.
" "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" " For cursor moving in insert mode(Not recommended)
" "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
" "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
" "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
" "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" " Or set this.
" "let g:neocomplete#enable_cursor_hold_i = 1
" " Or set this.
" "let g:neocomplete#enable_insert_char_pre = 1

" " AutoComplPop like behavior.
" "let g:neocomplete#enable_auto_select = 1

" " Shell like behavior(not recommended).
" "set completeopt+=longest
" "let g:neocomplete#enable_auto_select = 1
" "let g:neocomplete#disable_auto_complete = 1
" "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" " Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" " Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
" "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" " For perlomni.vim setting.
" " https://github.com/c9s/perlomni.vim
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" neosnippet
" Load custom snippets.
let g:neosnippet#snippets_directory = '~/dotfiles/snippets'
" Plugin key-mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" Move between windows using ctrl-[hjkl]
nnoremap <silent> <C-K> <C-W>k
nnoremap <silent> <C-J> <C-W>j
nnoremap <silent> <C-H> <C-W>h
nnoremap <silent> <C-L> <C-W>l

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Latex file encoding
" autocmd FileType plaintex setlocal fileencoding=utf8

" File encoding
set encoding=utf8

" Appearance
syntax on
set hlsearch
if has("gui_macvim")
  set guifont=Menlo:h12
endif

" Colorscheme
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

set background=dark
if has('mac')
  if !has('gui')
    let g:solarized_termtrans=0 " Required by iTerm2
  else
    let g:solarized_termtrans=1
  endif
  colorscheme solarized
else
  colorscheme advantage
endif

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50                 " keep 50 lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set nobackup                   " Disable the creation of backup files (the ones ending with ~)
set mouse=a                    " enable mouse 'all'
set number                     " line numbers
set scrolloff=1                " Keep the cursor away from top/bottom
set wildmode=longest,list      " TAB completion (such as bash)
set laststatus=2               " Always show a status bar
set smartcase                  " Ignore case when search pattern is all lowercase
set shiftwidth=2               " # of spaces of auto indent
set softtabstop=2              " # of spaces of <TAB> key
set tabstop=2                  " # of spaces erased when deleting a <TAB>
set expandtab                  " Insert spaces instead of tabs
set smarttab                   " 'siftwidth' in front of a line

