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
inoremap ii <esc>
inoremap II <esc>ZZ
"ii goes to normal, capitals exit
nnoremap ; :
"no need to shift in normal mode to go command line
cnoremap q1 q!
cnoremap write w !sudo tee %
"one less shift, what to do if forget to use sudo

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
