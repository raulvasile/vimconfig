" ---------------------------
" General settings
" ---------------------------
set history=700

filetype plugin on
filetype indent on

set autoread

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>

set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

set colorcolumn=80

" ---------------------------
" Vim Interface
" ---------------------------
set so=7

set wildmenu
set wildignore=*.o,*~,*.pyc

set ruler
set cmdheight=2
set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase

set hlsearch
set incsearch

set lazyredraw

set magic

set showmatch

set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

" ---------------------------
" Colors and fonts 
" ---------------------------
syntax enable

if has("gui_running")
	set guioptions-=T
	set guioptions+=e
	set t_Co=256
	set guitablebel=%M\ %t
endif

set encoding=utf8

set ffs=unix,dos,mac

" ---------------------------
" Files, backups and undo 
" ---------------------------
set nobackup
set nowb
set noswapfile

" ---------------------------
" Text, tab and indent related 
" ---------------------------
set expandtab
set smarttab

set shiftwidth=4
set tabstop=4

set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" ---------------------------
" Visual mode related 
" ---------------------------
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" ---------------------------
" Moving around, tabs, windows and buffers 
" ---------------------------
map j gj
map k gk

map <space> /
map <c-space> ?

map <silent> <leader><cr> :noh<cr>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>bd :Bclose<cr>

map <leader>ba :1,1000 bd!<cr>

map <leader>tn :tabnew<cr>
map <leader>tp :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

map <leader>te :tabedit <c-r>=expand("%p:h")<cr>/

map <leader>cd :cd %:p:h<cr>:pwd<cr>

try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

autocmd BufReadPost *
    \ if line("'\'") > 0 && line("'\'") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif

set viminfo^=%

" ---------------------------
" Status line 
" ---------------------------
set laststatus=2

set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \Line:\ %l

" ---------------------------
" Editing mappings 
" ---------------------------
map 0 ^

nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" ---------------------------
" Spell checking 
" ---------------------------
map <leader>ss :setlocal spell!<cr>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" ---------------------------
" Misc 
" ---------------------------
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

map <leader>q :e ~/buffer<cr>

map <leader>pp :setlocal paste!<cr>

" ---------------------------
" Helper function 
" ---------------------------
function! HasPaste()
    if &paste
        return 'PASTE MODE '
    en
    return ''
endfunction


" ---------------------------
" Start >> Vundle configuration
" ---------------------------
set nocompatible
filetype off

set regexpengine=1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin list
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomasr/molokai'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
" End of plugin list

" Plugins stuff
map <C-n> :NERDTreeToggle<CR>

let g:molokai_original=1
let g:rehash256=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

function! AirlineInit()
    let g:airline_section_a=airline#section#create(['mode',' ','branch'])
    let g:airline_section_b=airline#section#create_left(['ffenc','hunks','%f'])
    let g:airline_section_c=airline#section#create(['filetype'])
    let g:airline_section_x=airline#section#create(['%P'])
    let g:airline_section_y=airline#section#create(['%B'])
    let g:airline_section_z=airline#section#create_right(['%l','%c'])
endfunction

autocmd VimEnter * call AirlineInit()

call vundle#end()
filetype plugin indent on

" ---------------------------
" End >> Vundle configuration
" ---------------------------
