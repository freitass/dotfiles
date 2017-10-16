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
" Note: on MacOS there's a issue preventing <C-h> from working. Description
" and solution can be found here:
" https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
if has('nvim')
    tnoremap <silent> <C-k> <C-\><C-n><C-W>k
    tnoremap <silent> <C-j> <C-\><C-n><C-W>j
    tnoremap <silent> <C-h> <C-\><C-n><C-W>h
    tnoremap <silent> <C-l> <C-\><C-n><C-W>l

    " Enter/leave term buffer in insert mode
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
endif

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

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
" set nohlsearch                    " highlight matching string
set nobackup                      " Disable the creation of backup files (the ones ending with ~)
set mouse=a                       " enable mouse 'all'
set number                        " line numbers
set scrolloff=1                   " Keep the cursor away from top/bottom
set ignorecase smartcase          " Ignore case when search pattern is all lowercase
set shiftwidth=2                  " # of spaces of auto indent
set softtabstop=2                 " # of spaces of <TAB> key
set tabstop=2                     " # of spaces erased when deleting a <TAB>
set expandtab                     " Insert spaces instead of tabs
set smarttab                      " 'siftwidth' in front of a line
set clipboard=unnamed,unnamedplus " for simplified clipboard copy/paste

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

set path+=**
if has('wildmenu')
    set wildignore+=*.a,*.o
    set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
    set wildignore+=.DS_Store,.git,.hg,.svn
    set wildignore+=*~,*.swp,*.tmp
    set wildmenu
    set wildmode=longest,list  " TAB completion (such as bash)
endif

" Coming Home To Vim
inoremap jk <Esc>
if has('nvim')
    tnoremap jk <C-\><C-n>
endif

" Python support
if has('nvim')
    let g:python_host_prog = '/usr/local/bin/python'
    let g:python3_host_prog = '/usr/local/bin/python3'
endif

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

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install'}
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

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
nnoremap <silent> <F8> :NERDTreeToggle<CR>
nnoremap <silent> <leader>a :NERDTreeToggle<CR>

Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
let g:tagbar_sort      = 0  " Display tags the same order they appear in the source file
let g:tagbar_width     = 30 " Set Tagbar window width to 30
let g:tagbar_autofocus = 1  " Change the focus to the Tagbar window whenever it is opened
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> <leader>f :TagbarToggle<CR>

Plug 'ddollar/nerdcommenter'
" Map <C-/> to toggle comment both in normal and visual mode
nmap <leader>/ <plug>NERDCommenterToggle
vmap <leader>/ <plug>NERDCommenterToggle

Plug 'Lokaltog/vim-easymotion'
" Multichar search (iterate over the results with C-n)
nmap <leader>s <Plug>(easymotion-sn)
xmap <leader>s <Plug>(easymotion-sn)
omap <leader>s <Plug>(easymotion-sn)

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_always_populate_location_list = 1

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

Plug 'godlygeek/tabular'
nmap <silent> <leader>a= :<C-u>Tabularize /=<CR>
vmap <silent> <leader>a= :<C-u>Tabularize /=<CR>
nmap <silent> <leader>a: :<C-u>Tabularize /:<CR>
vmap <silent> <leader>a: :<C-u>Tabularize /:<CR>
nmap <silent> <leader>a:: :<C-u>Tabularize /:\zs<CR>
vmap <silent> <leader>a:: :<C-u>Tabularize /:\zs<CR>
nmap <silent> <leader>a, :<C-u>Tabularize /,<CR>
vmap <silent> <leader>a, :<C-u>Tabularize /,<CR>

Plug 'rhysd/vim-clang-format'
Plug 'kana/vim-operator-user'
" clang-format
" style_options: http://clang.llvm.org/docs/ClangFormatStyleOptions.html
let g:clang_format#command = "clang-format"
let g:clang_format#code_style = "google"
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -1,
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++03"}
" \ "UseTab" : "ForIndentation"}
" \ "SpaceAfterCStyleCast" : "true",
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc,objcpp nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc,objcpp vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc,objcpp map <buffer><Leader>x <Plug>(operator-clang-format)

Plug 'tpope/vim-fugitive'
set diffopt=filler,vertical
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gp :Git push<CR>
nmap <silent> <leader>gs :Gstatus<CR>

" Plug 'terryma/vim-smooth-scroll'
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 1)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 1)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 1)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 1)<CR>

Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'hewes/unite-gtags'
" Plug 'Shougo/neomru.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/unite-outline'

Plug 'c0nk/vim-gn'
Plug 'cohama/lexima.vim'
Plug 'embear/vim-foldsearch'
Plug 'ferranpm/vim-isolate'
Plug 'flazz/vim-colorschemes'
Plug 'freitass/todo.txt-vim'
Plug 'gcmt/wildfire.vim'
Plug 'h1mesuke/vim-unittest'
Plug 'mileszs/ack.vim'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/AnsiEsc.vim'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/cream-showinvisibles'
Plug 'wellle/visual-split.vim'

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

nnoremap [unite] <Nop>
nmap <space> [unite]
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#profile('default', 'context', {
            \   'start_insert' : 1,
            \   'smartcase' : 1,
            \   'winheight' : 10,
            \   'direction' : 'botright',
            \ })
" Start insert mode in unite-action buffer.
" call unite#custom#profile('action', 'context', {
"             \   'start_insert' : 1,
"             \   'smartcase' : 1,
"             \ })
nnoremap [unite]f :<C-u>Unite -start-insert -buffer-name=file_rec file_rec/async:!<CR>
" Unite: unite-source-history/yank
let g:unite_source_history_yank_enable = 1
nnoremap [unite]y :<C-u>Unite -buffer-name=yank history/yank<CR>
" Unite: unite-source-grep
let g:unite_source_grep_max_candidates = 200
" if executable('ag')
"   " Use ag in unite grep source.
"   let g:unite_source_grep_command = 'ag'
"   let g:unite_source_grep_default_opts =
"         \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
"         \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
"   let g:unite_source_grep_recursive_opt = ''
" elseif executable('pt')
"   " Use pt in unite grep source.
"   " https://github.com/monochromegane/the_platinum_searcher
"   let g:unite_source_grep_command = 'pt'
"   let g:unite_source_grep_default_opts = '-i --nogroup --nocolor'
"   let g:unite_source_grep_recursive_opt = ''
" elseif executable('ack-grep')
if executable('ack') || executable('ack-grep')
    " Use ack in unite grep source.
    let s:grep_command = 'ack-grep'
    if executable('ack')
        let s:grep_command = 'ack'
    endif
    let g:unite_source_grep_command = s:grep_command
    let g:unite_source_grep_default_opts =
                \ '--no-heading --no-color -k -H --sort-files --smart-case'
    let g:unite_source_grep_recursive_opt = ''
else
    let g:unite_source_grep_default_opts = '--exclude-dir=.svn -iIR'
endif
nnoremap [unite]<space> :<C-u>Unite<CR>
nnoremap [unite]ug :<C-u>Unite -buffer-name=grep grep:.::<CR>

" let g:unite_source_gtags_project_config = {
"       \ '_': { 'treelize': 1 }
"       \ }
" specify your project path as key.
" '_' in key means default configuration.
nnoremap [unite]gx :<C-u>Unite -buffer-name=gtags-context     gtags/context<CR>
nnoremap [unite]gr :<C-u>Unite -buffer-name=gtags-ref         gtags/ref<CR>
nnoremap [unite]gd :<C-u>Unite -buffer-name=gtags-def         gtags/def<CR>
nnoremap [unite]gg :<C-u>Unite -buffer-name=gtags-grep        gtags/grep<CR>
nnoremap [unite]gc :<C-u>Unite -buffer-name=gtags-completion  gtags/completion<CR>
nnoremap [unite]gf :<C-u>Unite -buffer-name=gtags-file        gtags/file<CR>

nnoremap [unite]o :<C-u>Unite -buffer-name=outline outline<CR>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    " Play nice with supertab
    let b:SuperTabDisabled=1
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

" """"""""""""""""""""""""""""""""""""""""""""""""
" Better key bindings for UltiSnipsExpandTrigger
" """"""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
call lexima#insmode#map_hook('before', '<CR>', '')

let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! UltiSnipsExpandSnippetOrCR()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  return g:ulti_expand_or_jump_res > 0 ? snippet : "\<CR>"
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnipsExpandSnippetOrCR()<CR>" : "<CR>"

" Search in project
nnoremap <leader>* :Ack! -w <c-r>=fnameescape(expand("<cword>"))<cr>

set exrc                          " enable per-directory .vimrc files
set secure                        " disable unsafe commands in local .vimrc files
