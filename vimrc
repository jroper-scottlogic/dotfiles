"in order to find this, create file ~/.vim/vimrc and add
"source ~/dotfiles/vimrc

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

"for linux use this
"set rtp+=~/.vim/bundle/Vundle.vim
"for windows use this
set shellslash
set rtp+=~/vimfiles/bundle/Vundle.vim

"allows nerdtree git functionality
"set shell=sh

call vundle#begin()

"let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
"input all necessry plugins here
"ui
Plugin 'bling/vim-airline'  "add some helpful info at bottom of screen
Plugin 'nathanaelkane/vim-indent-guides'    "highlights indents for prettiness
Plugin 'sainnhe/gruvbox-material'   "nice colourscheme
Plugin 'sheerun/vim-polyglot'   "used by gruvbox-material helps with highlighting
Plugin 'frazrepo/vim-rainbow'   "rainbow highlighting of parenthesis

"git
Plugin 'tpope/vim-fugitive' "Run git commands :G or :Git from command
Plugin 'airblade/vim-gitgutter' "Show git changes in sign column

"nerdtree
Plugin 'preservim/nerdtree'   "display directory from vim
Plugin 'Xuyuanp/nerdtree-git-plugin'    "adds git status flags to nerdtree

"functionality
Plugin 'tpope/vim-surround' "quickly change surrounding parentheses cs, ds, ys
Plugin 'valloric/youcompleteme' "tab to autocomplete

"Plugin 'SirVer/ultisnips'   "quickly paste phrases
"Plugin 'honza/vim-snippets' "ultisnips for python
"Plugin 'easymotion/vim-easymotion'  "faster navigation, uses \\

Plugin 'dense-analysis/ale'   "linter

call vundle#end()
filetype plugin indent on

"ALE
let g:ale_sign_error = '*'
let g:ale_sign_warning = '.'
let g:ale_set_highlights = 0

let g:airline#extensions#ale#enabled = 1

let g:ale_fixers = {'javascript': ['prettier']}

"NERDTree auto starts
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 
            \&& exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

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

"allow cursor to go to end of line in normal mode
set virtualedit+=onemore

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
"run python files by typing from within vim
autocmd FileType python cmap zz w<CR>;exec '!python3' shellescape(@%, 1)<CR>

"Ctrl e jumps to next ale error
nmap <silent> <C-e> <Plug>(ale_next_wrap)

"faster get to nerdtree
cmap ntt NERDTree

"ii goes to normal, capitals exit
imap ii <esc>l
inoremap II <esc>ZZ

"no need to shift in normal mode to go command line
nnoremap ; :
nnoremap : ;
"insert new line above/below but stay in normal mode
nnoremap oo o<esc>k
nnoremap OO O<esc>j
"delete whole line but leave blank space
nnoremap da 0D

"one less shift, what to do if forget to use sudo
cnoremap q1 q!
cnoremap write w !sudo tee %

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
