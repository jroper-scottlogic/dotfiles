"remember cursor position, among other things
source $VIMRUNTIME/vimrc_example.vim
"makes sure the viminfo file is in the .vim dir
set viminfo+=n~/.vim/viminfo 
set viminfofile=~/.vim/viminfo
"stops anything appearing in buffer
set t_u7=   
"makes <esc> remaps work
set nocompatible    
"allow more normal backspacing
set backspace=indent,eol,start  

"in order to use Vundle, vim plugin manager
filetype off

"if Vundle needs to be downloaded use the following
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"in order to download it

"set runtime path to inclue Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
"input all necessry plugins here
Plugin 'tpope/vim-surround' "quickly change surrounding parentheses cs, ds, ys
Plugin 'scrooloose/syntastic'   "syntax checker
Plugin 'bling/vim-airline'  "add some helpful info at bottom of screen
Plugin 'SirVer/ultisnips'   "quickly paste phrases
Plugin 'honza/vim-snippets' "ultisnips for python
Plugin 'easymotion/vim-easymotion'  "faster navigation, uses \\
Plugin 'nathanaelkane/vim-indent-guides'    "highlights indents for prettiness
Plugin 'sainnhe/gruvbox-material'   "nice colourscheme
Plugin 'sheerun/vim-polyglot'   "used by gruvbox-material helps with highlighting
Plugin 'frazrepo/vim-rainbow'   "rainbow highlighting of parenthesis
"end input
call vundle#end()
filetype plugin indent on

"sysntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"tabbing stuff
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set textwidth=80

"get rid of that annoying bell sound
set belloff=all
set noerrorbells

"give extra info
set number
set showcmd
set cc=80

"searching
set incsearch
set hlsearch

"functions to make calling spell checker faster
function! SpellCheck()
    set spell
endfu
command! SC call SpellCheck()

function! SpellUncheck()
    set nospell
endfu
command! UC call SpellUncheck()

"attempt to use gruvbox-material
syntax enable   "Use syntax highlighting                        
set showmatch
if has('termguicolors')
    set termguicolors
endif

"for background
set background=dark

"for contrast
let g:gruvbox_material_background = 'soft'

"for better performance
let g:gruvbox_material_better_performance = 1

"actually use it
colorscheme gruvbox-material

"indent guides
let g:indent_guides_enable_on_vim_startup = 1
"make indent colours nicer
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#665c54
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#a89984

"rainbow parenthesis
let g:rainbow_active = 1

"hide window on close ... or at least try to
set hidden

"keep cursor a certain distance from top/bottom
set scrolloff=5

"remappping modes:
":map - alllll
":nmap - normal mode maps
":imap - insert mode maps
":vmap - visual and select mode maps
":smap - select mode maps
":xmap - visual mode maps
":cmap - command line mode maps
":omap - operator pending mode maps

"remapping
"ii goes to normal, capitals exit
imap ii <esc>l
inoremap II <esc>ZZ

"no need to shift in normal mode to go command line
nnoremap ; :
nnoremap : ;
"insert new line below but stay in normal mode
nnoremap oo o<esc>k
"insert new line above but stay in normal mode
nnoremap OO O<esc>j
"delete whole line but leave blank space
nnoremap da 0D

"one less shift, what to do if forget to use sudo
cnoremap q1 q!
cnoremap write w !sudo tee %
cnoremap sr SyntasticReset

"disable arrow keys in normal mode
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Right> <Nop>
nnoremap <Left> <Nop>

"disable arrow keys in visual mode
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Right> <Nop>
vnoremap <Left> <Nop>

"disable arrow keys in insert mode
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Right> <Nop>
inoremap <Left> <Nop>
