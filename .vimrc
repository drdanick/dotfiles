" vim: set sts=4 et fdm=marker:
" ==================================
" ==================================
"   Nick's Good Enough (tm) .vimrc
"
"   Copy this at your own risk! :)
" ==================================
" ==================================

set nocompatible " The !Most Important! setting. Be vim, not vi.

" SECTION: PLUGINS {{{
" ============================================

filetype off " Required for vundle

" I use Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle (required)
Plugin 'VundleVim/Vundle.vim'

"
" Feature Plugins
"

" Swap to header files easily (using a fork to avoid annoying insert mode mappings)
Plugin 'fanchangyong/a.vim'

" Alternative to powerline
Plugin 'bling/vim-airline'

" Themes for airline
Plugin 'vim-airline/vim-airline-themes'

" C library reference browser
" Map cq to avoid cc being mapped (nerdcommenter should get that binding)
map <Leader>cq <Plug>CRV_CRefVimInvoke
Plugin 'CRefVim'

" Nice tag based browsing of source
Plugin 'taglist.vim'

" Switch buffers easily
Plugin 'minibufexpl.vim'

" Extremely powerful semantic source completion
Plugin 'ycm-core/YouCompleteMe'

" Auto close brackets and quotes
Plugin 'Raimondi/delimitMate'

" Good file browsing
Plugin 'scrooloose/nerdtree'

" Better commenting
Plugin 'scrooloose/nerdcommenter'

" Undo branch visualizer
Plugin 'mbbill/undotree'

" Prolog integration
Plugin 'adimit/prolog.vim'

" Cscope database integration
Plugin 'cscope.vim'

" Valgrind integration
Plugin 'valgrind.vim'

" Arduino support
Plugin 'kingbin/vim-arduino'

" Latex integration
Plugin 'vim-latex/vim-latex'

" Nice window swapping
Plugin 'wesQ3/vim-windowswap'

" Tab management
Plugin 'kien/tabman.vim'

" scm diff indicators in gutter
Plugin 'mhinz/vim-signify'

"
" Syntax Plugins
"

" Apricos syntax highlighting
Plugin 'drdanick/apricos.vim'

" General log file highlighting
Plugin 'dzeban/vim-log-syntax'

"
" Colorscheme Plugins
"
Plugin 'tomasr/molokai'
Plugin 'fmoralesc/molokayo'
Plugin 'altercation/vim-colors-solarized'


call vundle#end()         " End vundle init
filetype indent plugin on " Required AFTER vundle init

" }}}
" SECTION: CORE VIM SETTINGS {{{
" ============================================
set laststatus=2                " Always show status line

set encoding=utf-8              " Necessary for unicode glyphs
set t_Co=256
set t_ut=

" Store vim swapfiles in a common directory
set dir=~/.vimswap//,.,/var/tmp//,/tmp//,

" Let us open up to 20 tabs at once from the commandline
set tabpagemax=20

" Mouse settings
set mouse=n
set guicursor+=a:blinkon0

" Fix mouse mode in tmux
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
elseif has("mouse_sgr")
    " Allow mouse to move past the 220th column even outside of tmux
    " This also fixes mouse issues in some environments (like WSL)
    set ttymouse=sgr
else
    " Set the extended mouse mode anyway. Comment out this line if the mouse
    " starts freaking out or not working.
    set ttymouse=xterm2
endif

syntax enable
set modeline

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
filetype plugin on
set linespace=3

set nu    " Show line numbers

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L
set guioptions-=b

set history=256         " Number of things to remember in history.
"set autowrite           " Writes on make/shell commands
set autoread            " Read on file change
set timeoutlen=200      " Time to wait after ESC, 0 bugs out some keypresses
"set clipboard+=unnamed  " Yanks go on clipboard instead.

set hlsearch                    " highlight search
set ignorecase                  " Do case in sensitive matching with
set smartcase                   " Be sensitive when there's a capital letter
set incsearch                   " Incremental search
set backspace=indent,eol,start  " more powerful backspacing

set nowrap
set textwidth=0                 " Don't wrap lines by default

set wildmenu  " Interactive : command tab completion

"
" GVIM fixes
"

" Auto gvim redraw on focus to mitigate artifacting
au FocusGained * :redraw!

" Redraw on ctrl+s to mitigate artifacting
inoremap <c-s> <c-o>:redraw!<cr>
nmap <c-s> :redraw!<cr>

" }}}
" SECTION: KEY BINDINGS {{{
" ============================================

" Discourage arrow keys by disabling them in normal mode
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Back out of insert mode by pressing 'jj'
inoremap jj <Esc>

" slightly nicer navigation for files with wrapped lines
nnoremap j gj
nnoremap k gk

let mapleader = ' '             " Bind <leader> to space.
map <leader>e :e! ~/.vimrc<cr>  " Fast editing of the .vimrc

" Fast tab creation/navigation
nmap { :tabprevious<cr>
nmap } :tabnext<cr>
nmap W :close<cr>
nmap T :tabnew<cr>

" }}}
" SECTION: THEME SETTINGS {{{
" ============================================

if has("gui_running") " Used solarized in gvim
    colo solarized
else                  " Use molokai in terminal vim
    let g:molokai_original = 1
    let g:rehash256 = 1
    colo molokai
endif
set background=dark        " Prefer the dark theme variant if available
highlight clear SignColumn " Get rid of the annoying highlight on the gutter

" This font seems to look okay. Consolas is another good option.
set guifont=Liberation\ Mono\ 9


" }}}
" SECTION: CUSTOM COMMANDS {{{
" ============================================

" Sudo write
comm! W exec 'w !sudo tee % > /dev/null'

" }}}
" SECTION: CUSTOM FUNCTIONS AND COMMANDS {{{
" ============================================


function TexSettings()
    set linebreak
    set wrap
endfunction
command Texsettings exec TexSettings()

function ShowGutter()
    sign define dummy
    execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
endfunction
command ShowGutter exec ShowGutter()
command SG exec ShowGutter()

"
" Useful command aliases
"

command HideGutter sign unplace *
command HG HideGutter

" Highlight trailing whitespace
command ShowWSTrailing /\s\+$

" Highlight whitespace before tabs
command ShowWSBeforeTabs / \+\ze\t

" Highlight tabs
command ShowWSTabs /\t

" Highlight mixed leading whitespace
command ShowWSMixedLeading /^\t* \+\t*\ze\S\+.*$

" Highlight mixed whitespace
command ShowWSMixed /\(\zs \+\ze\t\+\)\|\(\t\+\zs \+\ze\)

" }}}
" SECTION: PLUGIN SETTINGS {{{

"
" NERDTree settings
"
let NERDTreeQuitOnOpen=1
map <Leader>n :NERDTreeToggle<cr>
map <Leader>t :TlistToggle<cr>


"
" MiniBufExplorer settings
"
let g:miniBufExplCloseOnSelect=1
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplorerMoreThanOne=100
map <Leader>b :MiniBufExplorer<cr>

"
" Airline settings
"
let g:airline_theme = 'zenburn'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1

"
"  Undotree settings
"
nmap <F5> :UndotreeToggle<CR>

"
" YouCompleteMe settings
"
let g:ycm_complete_in_strings = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_server_keep_logfiles = 0

"
" TabMan settings
"

let g:tabman_toggle = '<leader>tt'

"
" Apricos settings
"

" This fixes comment formatting
autocmd FileType apricos setl cms=;%s


" }}}
