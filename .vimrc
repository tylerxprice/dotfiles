filetype off
execute pathogen#infect()
syntax on                   " turn syntax highlighting on by default
filetype on                 " detect type of file
filetype indent on          " load indent file for specific file type


" Basic Settings ============================================================== {{{
set nocompatible

let mapleader = ","         " , is easier to hit than \

set modelines=0             " fix a security hole
set encoding=utf-8          " encoding for i8n
set ttyfast                 " fast redrawing
set nobackup                " do not keep a backup file
"set undofile               " allow for undo actions after reopening file
set backspace=indent,eol,start  " make that backspace key work the way it should
set novisualbell t_vb=      " no ding/flash
set t_RV=

set scrolloff=3             " keep 3 lines when scrolling
set showmode                " display current mode
set showcmd                 " display incomplete commands

set nonumber                " hide line numbers
"set relativenumber          " show number lines relative to current line
set ruler                   " show the current row and column
set laststatus=2            " always show buffer status

set wrap                    " wraps lines, horizontal scrolling is lame
set colorcolumn=160         " 85a marker to indicate your line is too long
set list                    " show non-text character placeholders
set listchars=tab:▸\ ,eol:¬ " specify which characters to show

"let g:load_doxygen_syntax=1
" }}}


" Searching =================================================================== {{{
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present
noremap <silent> <leader><Space> :nohlsearch<cr>:call clearmatches()<cr>

set grepprg=ag\ --nogroup\ --nocolor

""set grepprg=C:/MinGW/msys/1.0/bin/grep\ -nR\ --exclude-dir=.hg --include={*.s,*.arm,*.c,*.h,*.cpp,*.hpp,*.py,*.gpj,*.yml,*.tpl,*.ld}\ $*\ *
"augroup grepprog
"    autocmd!
"    autocmd FileType vim setlocal grepprg=C:/MinGW/msys/1.0/bin/grep\ -nR\ --exclude-dir={.hg,.git}\ --include={*.vim}\ $*\ *
"    autocmd FileType c,cpp setlocal grepprg=C:/MinGW/msys/1.0/bin/grep\ -nR\ --exclude-dir={.hg,.git}\ --include={*.c,*.h,*.cpp,*.hpp,*.s,*.arm,*.gpj,*.ld}\ $*\ *
"    autocmd FileType python setlocal grepprg=C:/MinGW/msys/1.0/bin/grep\ -nR\ --exclude-dir={.hg,.git}\ --include={*.py}\ $*\ *
"augroup END
"
"nnoremap <leader>g :grep 
nnoremap <leader>G :silent execute "grep! " . shellescape(expand('<cword>'))<CR>:redraw!<CR>:clist<CR>
""nnoremap <leader>G :silent execute 'grep! ' . shellescape(expand('<cWORD>'))<CR>:clist
"
"nnoremap <leader>G :set operatorfunc=rc:GrepOperator<CR>g@
"vnoremap <leader>G :<c-u>call rc:GrepOperator(visualmode())<CR>
"
"function! rc:GrepOperator(type)
"    let saved_unnamed_register = @@
"
"    if a:type ==# 'v'
"        execute "normal! `<v`>y"
"    elseif a:type ==# 'char'
"        execute "normal! `[v`]y"
"    else
"        return
"    endif
"
"    silent execute "grep! " . shellescape(@@)
"    echo "grepping..."
"
"    let @@ = saved_unnamed_register
"endfunction
"
"
"
"
"function! rc:GotoJump()
"  jumps
"  let j = input("Please select your jump: ")
"  if j != ''
"    let pattern = '\v\c^\+'
"    if j =~ pattern
"      let j = substitute(j, pattern, '', 'g')
"      execute "normal " . j . "\<c-i>"
"    else
"      execute "normal " . j . "\<c-o>"
"    endif
"  endif
"endfunction
"
"nmap <leader>j :call rc:GotoJump()<CR>

" }}}


" Indentation ================================================================= {{{
set autoindent          " set auto-indenting on for programming
set smartindent         " C-like indenting
set tabstop=4           " Four space tabs
set shiftwidth=4
set softtabstop=4
set expandtab
" }}}


" Folding ===================================================================== {{{
set foldmethod=syntax   " fold on syntax (good for C/C++ but not python)
set nofoldenable        " don't fold by default
augroup folding
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType python setlocal foldmethod=indent
augroup END

" }}}


" Completion ================================================================== {{{
"set path+=**
"set wildmenu
"set wildmode=list:longest
"set wildignore+=**/.git/**
" }}}


" Colors ====================================================================== {{{
set background=light
color mayansmoke

function! NegativeColor()
    if &background == 'light'
        set background=dark
        color wombat
    else
        set background=light
        color mayansmoke
    endif
endfunction
nnoremap <leader>b :call NegativeColor()<CR>
" }}}


" Cursorline ================================================================== {{{
" Only show cursorline in the current window and in normal mode.
set cursorline
augroup cline
    autocmd!
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd WinEnter,InsertLeave * set cursorline
augroup END

" }}}


" Line Return ================================================================= {{{
" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au bufreadpost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
" }}}


" Backups ===================================================================== {{{
"set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" }}}


" GUI Options ================================================================= {{{
if has("win32")
    set guifont=Lucida_Console:h9
endif
set guioptions-=m       "remove menu bar
set guioptions-=T       "remove toolbar
"set guioptions-=r       "remove right-hand scroll bar

" }}}


" Mappings ==================================================================== {{{
" source/edit vimrc
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" easier windows copy/paste
"vnoremap <leader>y "+y
"nnoremap <leader>p "+p
"nnoremap <leader>d "+d
set clipboard=unnamedplus

" escape is too hard to reach
:inoremap <Esc> <Nop>
:inoremap jk <Esc>

" update ctags and cscope index files
"
"nnoremap <F5> :silent !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q && cscope -bRC<CR>
"             \:cs kill -1<CR>
"             \:cs add cscope.out<CR><CR>
"
"nnoremap <F5> :silent !cscope -bR<CR>
"             \:cs kill -1<CR>
"             \:cs add cscope.out<CR><CR>
"
"nnoremap <F6> :silent !ctags -R --python-kinds=-i<CR>
"
"nmap <leader>r :cs find s <C-R>=expand("<cword>")<CR><CR>

" windowing: easy vsplit and moving between windows
set splitright
nnoremap <leader>w <C-w>v<C-w>l
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l


" quickfix and file list navigation
nnoremap <left>  :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up>    :lprev<cr>zvzz
nnoremap <down>  :lnext<cr>zvzz

"scratch.vim
"nnoremap <leader>S :Sscratch<CR>

" }}}


" Taglist ===================================================================== {{{
nnoremap <leader>t :Tlist<CR>
let Tlist_Ctags_Cmd = 'ctags --extra=-q --c++-kinds=-p'
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)
let tlist_sql_settings = 'sql;P:package;t:table'
let tlist_ant_settings = 'ant;p:Project;r:Property;t:Target'
" }}}


" NERDTree ==================================================================== {{{
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>N :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$','\.d$','\.o$','\.fmt$','\.orig$']
"autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
" returns true iff is NERDTree open/active
"function! rc:isNTOpen()        
"  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
"endfunction
"
"" returns true iff focused window is NERDTree window
"function! rc:isNTFocused()     
"  return -1 != match(expand('%'), 'NERD_Tree') 
"endfunction 
"
"" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
"function! rc:syncTree()
"  if &modifiable && rc:isNTOpen() && !rc:isNTFocused() && strlen(expand('%')) > 0 && !&diff
"    NERDTreeFind
"    wincmd p
"  endif
"endfunction

augroup nerdtreegroup
    autocmd!
    "autocmd BufEnter * call rc:syncTree()
    autocmd Filetype nerdtree setlocal nolist
augroup END
" }}}


" SuperTab ==================================================================== {{{
"let g:SuperTabDefaultCompletionType = "<c-n>"
"let g:SuperTabLongestHighlight = 1
" }}}


" Ctrl+p ====================================================================== {{{
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(d|o|exe|so|dll|rej|orig)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }
" }}}






