"in order to find this, create file ~/.vim/vimrc and add
"source ~/dotfiles/vimrc

"remember cursor position, among other things
"source $VIMRUNTIME/vimrc_example.vim
"makes sure the viminfo file is in the .vim dir
set viminfo+=n~/.vim/viminfo 
set viminfofile=~/.vim/viminfo
"stops anything appearing in buffer
set t_u7=   
"makes <esc> remaps work
set nocompatible    
"allow more normal backspacing
set backspace=indent,eol,start  

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
"ui
Plug 'bling/vim-airline'  "add some helpful info at bottom of screen
Plug 'nathanaelkane/vim-indent-guides'    "highlights indents for prettiness
Plug 'sainnhe/gruvbox-material'   "nice colourscheme
Plug 'sheerun/vim-polyglot'   "used by gruvbox-material helps with highlighting
Plug 'kien/rainbow_parentheses.vim'   "rainbow highlighting of parenthesis
Plug 'pangloss/vim-javascript'  "better syntax highlighting and improved indentation for js
Plug 'othree/html5.vim'	"better syntax highlighting for html
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }	"show colours as they're written

"functionality
Plug 'tpope/vim-surround' "quickly change surrounding parentheses cs, ds, ys

"git
Plug 'tpope/vim-fugitive' "Run git commands :G or :Git from command
Plug 'airblade/vim-gitgutter' "Show git changes in sign column

"nerdtree
Plug 'preservim/nerdtree'   "display directory from vim
Plug 'Xuyuanp/nerdtree-git-plugin'    "adds git status flags to nerdtree

"linting
Plug 'dense-analysis/ale'   "linter
call plug#end()

"ALE
let g:ale_sign_error = '*'
let g:ale_sign_warning = '.'
let g:ale_set_highlights = 0
let g:ale_completion_enabled = 1

let g:airline#extensions#ale#enabled = 1

let g:ale_fixers = {
			\'javascript': ['eslint'],
			\'html': ['prettier'],
			\'*': ['remove_trailing_lines', 'trim_whitespace'],
			\}

let g:ale_linters = {
			\'javasctipt': ['eslint'],
			\}

"NERDTree auto starts
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 
            "\&& exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

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

"for rainbow parenthese
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"for highlighting rgb/hex values
let g:Hexokinase_highlighters = ['virtual', 'backgroundfull']
let g:Hexokinase_optInPatterns = ['full_hex','rgb','rgba','hsl','hsla','colour_names']

"suppress 'hit enter to continue' prompt when opening with vim
"set shortmess=a

"tabbing stuff
set noexpandtab
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
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#300000
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#99AB89

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

"ZA writes current window and attemps to close all others
nnoremap ZA :only<CR>:wq<CR>
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
