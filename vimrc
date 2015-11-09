if !has('nvim')
  set nocompatible
  set encoding=utf8
  if $COLORTERM == 'gnome-terminal'
    set t_Co=256
  endif
endif

let mapleader = ","

filetype plugin indent on

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Move between windows using ctrl-[hjkl]
nnoremap <silent> <C-k> <C-W>k
nnoremap <silent> <C-j> <C-W>j
nnoremap <silent> <C-h> <C-W>h
nnoremap <silent> <C-l> <C-W>l
tnoremap <silent> <C-k> <C-\><C-n><C-W>k
tnoremap <silent> <C-j> <C-\><C-n><C-W>j
tnoremap <silent> <C-h> <C-\><C-n><C-W>h
tnoremap <silent> <C-l> <C-\><C-n><C-W>l

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Latex file encoding
" autocmd FileType plaintex setlocal fileencoding=utf8

" Appearance
syntax on
if has("gui_macvim")
  set guifont=Menlo:h12
endif

set backspace=indent,eol,start    " allow backspacing over everything in insert mode
set history=50                    " keep 50 lines of command line history
set ruler                         " show the cursor position all the time
set showcmd                       " display incomplete commands
set incsearch                     " do incremental searching
set nohlsearch                    " highlight matching string
set nobackup                      " Disable the creation of backup files (the ones ending with ~)
set mouse=a                       " enable mouse 'all'
set number                        " line numbers
set scrolloff=1                   " Keep the cursor away from top/bottom
set wildmode=longest,list         " TAB completion (such as bash)
set ignorecase smartcase          " Ignore case when search pattern is all lowercase
set shiftwidth=2                  " # of spaces of auto indent
set softtabstop=2                 " # of spaces of <TAB> key
set tabstop=2                     " # of spaces erased when deleting a <TAB>
set expandtab                     " Insert spaces instead of tabs
set smarttab                      " 'siftwidth' in front of a line
set clipboard=unnamed,unnamedplus " for simplified clipboard copy/paste

set exrc                          " enable per-directory .vimrc files
set secure                        " disable unsafe commands in local .vimrc files

set laststatus=2                  " Always show a status bar
set statusline=
set statusline+=%<\                            " cut at start
set statusline+=%*[%n%H%M%R%W]%*\              " flags and buf no
set statusline+=%-40f\                         " path
set statusline+=%{fugitive#statusline()}       " git branch
set statusline+=%=[%{strlen(&ft)?&ft:'none'}\  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}]   " encoding
set statusline+=%10((%l,%c)%)\                 " line and column
set statusline+=%P                             " percentage of file

if has('wildmenu')
  set wildignore+=*.a,*.o
  set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
  set wildignore+=.DS_Store,.git,.hg,.svn
  set wildignore+=*~,*.swp,*.tmp
  set wildmenu
  set wildmode=longest,list
endif

" add list lcs=tab:>-,trail:x for tab/trailing space visuals
" set list
" set lcs=tab:>-,trail:x
autocmd BufEnter ?akefile* set noet ts=8 sw=8 nocindent

" Coming Home To Vim
inoremap jk <Esc>
tnoremap jk <C-\><C-n>

" Start external command with a single bang
nnoremap ! :!

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.vim/bundle/'))

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
  let g:make = 'make'
endif

let g:fzf_install = 'yes | ./install'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': g:fzf_install}
Plug 'junegunn/fzf.vim'
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
nnoremap <c-p> :Files<CR>
nnoremap <leader><c-p> :Buffers<CR>
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Plug 'Shougo/unite.vim'
" nnoremap [unite] <Nop>
" nmap <space> [unite]

" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" " Start insert mode in unite-action buffer.
" call unite#custom#profile('action', 'context', {
"       \   'start_insert' : 1,
"       \   'smartcase' : 1
"       \ })
" nnoremap [unite]f :<C-u>Unite -start-insert file_rec/async:!<CR>
" " Unite: unite-source-history/yank
" let g:unite_source_history_yank_enable = 1
" nnoremap [unite]y :<C-u>Unite history/yank<CR>
" " Unite: neosnippet-unite-source-neosnippet
" nnoremap [unite]s :<C-u>Unite neosnippet<CR>
" " Unite: unite-source-grep
" let g:unite_source_grep_max_candidates = 200
" " if executable('ag')
" "   " Use ag in unite grep source.
" "   let g:unite_source_grep_command = 'ag'
" "   let g:unite_source_grep_default_opts =
" "         \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
" "         \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
" "   let g:unite_source_grep_recursive_opt = ''
" " elseif executable('pt')
" "   " Use pt in unite grep source.
" "   " https://github.com/monochromegane/the_platinum_searcher
" "   let g:unite_source_grep_command = 'pt'
" "   let g:unite_source_grep_default_opts = '-i --nogroup --nocolor'
" "   let g:unite_source_grep_recursive_opt = ''
" " elseif executable('ack-grep')
" if executable('ack') || executable('ack-grep')
"   " Use ack in unite grep source.
"   let s:grep_command = 'ack-grep'
"   if executable('ack')
"     let s:grep_command = 'ack'
"   endif
"   let g:unite_source_grep_command = s:grep_command
"   let g:unite_source_grep_default_opts =
"         \ '--no-heading --no-color -k -H --sort-files --smart-case'
"   let g:unite_source_grep_recursive_opt = ''
" else
"   let g:unite_source_grep_default_opts = '--exclude-dir=.svn -iIR'
" endif
" nnoremap [unite]ug :<C-u>Unite grep:.::<CR>

" Plug 'hewes/unite-gtags'
" " let g:unite_source_gtags_project_config = {
" "       \ '_': { 'treelize': 1 }
" "       \ }
" " specify your project path as key.
" " '_' in key means default configuration.
" nnoremap [unite]gx :<C-u>Unite gtags/context<CR>
" nnoremap [unite]gr :<C-u>Unite gtags/ref<CR>
" nnoremap [unite]gd :<C-u>Unite gtags/def<CR>
" nnoremap [unite]gg :<C-u>Unite gtags/grep<CR>
" nnoremap [unite]gc :<C-u>Unite gtags/completion<CR>

" Plug 'Shougo/neocomplete'
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

" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" " Load custom snippets.
" let g:neosnippet#snippets_directory = '~/dotfiles/snippets'
" " Plugin key-mappings.
" " imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" " smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" " xmap <C-k>     <Plug>(neosnippet_expand_target)
" " SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"       \ "\<Plug>(neosnippet_expand_or_jump)"
"       \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"       \ "\<Plug>(neosnippet_expand_or_jump)"
"       \: "\<TAB>"
" " For snippet_complete marker.
" if has('conceal')
"   set conceallevel=2 concealcursor=i
" endif

" Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Plug 'Shougo/vimshell.vim'
" Plug 'Shougo/neomru.vim'

Plug 'scrooloose/nerdtree'
nnoremap <silent> <F8> :NERDTreeToggle<CR>
nnoremap <silent> <leader>a :NERDTreeToggle<CR>

Plug 'majutsushi/tagbar'
let g:tagbar_sort      = 0  " Display tags the same order they appear in the source file
let g:tagbar_width     = 30 " Set Tagbar window width to 30
let g:tagbar_autofocus = 1  " Change the focus to the Tagbar window whenever it is opened
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> <leader>f :TagbarToggle<CR>

Plug 'ddollar/nerdcommenter'
" Map <C-/> to toggle comment both in normal and visual mode
nmap  <plug>NERDCommenterToggle
vmap  <plug>NERDCommenterToggle
nmap <leader>/ <plug>NERDCommenterToggle
vmap <leader>/ <plug>NERDCommenterToggle

Plug 'Lokaltog/vim-easymotion'
" Multichar search (iterate over the results with C-n)
nmap <leader>s <Plug>(easymotion-sn)
xmap <leader>s <Plug>(easymotion-sn)
omap <leader>s <Plug>(easymotion-sn)

" Plug 'Valloric/YouCompleteMe'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

Plug 'godlygeek/tabular'
nmap <silent> <leader>a= :<C-u>Tabularize /=<CR>
vmap <silent> <leader>a= :<C-u>Tabularize /=<CR>
nmap <silent> <leader>a: :<C-u>Tabularize /:<CR>
vmap <silent> <leader>a: :<C-u>Tabularize /:<CR>
nmap <silent> <leader>a:: :<C-u>Tabularize /:\zs<CR>
vmap <silent> <leader>a:: :<C-u>Tabularize /:\zs<CR>
nmap <silent> <leader>a, :<C-u>Tabularize /,<CR>
vmap <silent> <leader>a, :<C-u>Tabularize /,<CR>

" Plug 'kien/ctrlp.vim'
" Plug 'FelikZ/ctrlp-py-matcher'
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
" let g:ctrlp_match_window = 'bottom,order:ttb'
" let g:ctrlp_working_path_mode = ''  " working path won't change when opening new files
" let g:ctrlp_switch_buffer = 'Et'    " jump to opened window (if any)
" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" let g:ctrlp_follow_symlinks = 1

Plug 'rhysd/vim-clang-format'
Plug 'kana/vim-operator-user'
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

Plug 'vim-scripts/a.vim'
map <silent> <C-Tab> :A<CR>

Plug 'tpope/vim-fugitive'
set diffopt=filler,vertical
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gp :Git push<CR>
nmap <silent> <leader>gs :Gstatus<CR>

Plug 'cohama/lexima.vim'
Plug 'cream-showinvisibles'
Plug 'embear/vim-foldsearch'
Plug 'ferranpm/vim-isolate'
Plug 'flazz/vim-colorschemes'
Plug 'freitass/todo.txt-vim'
Plug 'gcmt/wildfire.vim'
Plug 'h1mesuke/vim-unittest'
Plug 'mileszs/ack.vim'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/AnsiEsc.vim'

call plug#end()

set background=dark
if has('mac')
  if !has('gui')
    let g:solarized_termtrans=0 " Required by iTerm2
  else
    let g:solarized_termtrans=1
  endif
  colorscheme solarized
else
  colorscheme tango-desert
endif

