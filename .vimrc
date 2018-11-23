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
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme darkblue
endtry

"spell checker, activated with 'WP'
func! WordProcessorMode()
    setlocal textwidth=100
    setlocal smartindent
    setlocal spell spelllang=en_gb
    setlocal noexpandtab
endfu
com! WP call WordProcessorMode()

"remapping
inoremap jk <esc>   
inoremap <esc> <Nop>
"jk in insert goes to normal, can't use esc
nnoremap ; :
"no need to shift in normal mode to go visual
cnoremap q1 q!
"one less shift

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
