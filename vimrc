"in order to use Vundle, vim plugin manager
set nocompatible
filetype off

"set runtime path to inclue Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
"input all necessry plugins here
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'easymotion/vim-easymotion'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'raimondi/delimitmate'
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

"give extra info
set number
set showcmd
set cc=80

"searching
set incsearch
set hlsearch

"attempt to use solarized                             
"https://github.com/altercation/vim-colors-solarized                            
syntax enable                   "Use syntax highlighting                        
set background=dark             "Use dark color scheme                          
try
    let g:solarized_termtrans = 1 "gets rid of ugly grey background
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme darkblue
    hi Comment ctermfg=4
endtry

"change highlighting of comments to blue
"hi Comment ctermfg=4

"hide window on close ... or at least try to
set hidden

"spell checker, activated with 'WP' honestly useless
func! WordProcessorMode() 
    setlocal textwidth=100
    setlocal smartindent
    setlocal spell spelllang=en_gb
    setlocal noexpandtab
endfu
com! WP call WordProcessorMode()

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
inoremap ii <esc>
inoremap II <esc>ZZ
"no need to shift in normal mode to go command line
nnoremap ; :
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
