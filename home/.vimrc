""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> vim-plug Plugins
"    -> NEO VIM
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Auto commands
"    -> Hotkeys/Keymaps
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has('nvim')
  set ttymouse=xterm2
  set termguicolors
  execute "set t_8f=\e[38;2;%lu;%lu;%lum"
  execute "set t_8b=\e[48;2;%lu;%lu;%lum"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" SYNTAX HIGHLIGHTING
" Coffeescript
Plug 'https://github.com/kchmck/vim-coffee-script.git'

" Handlebars
Plug 'mustache/vim-mustache-handlebars'

" CSS3/SASS (scss)
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

" Better JSON
Plug 'elzr/vim-json'

" Better JS
Plug 'pangloss/vim-javascript'

" VIM MOTIONS
" Surround
Plug 'tpope/vim-surround'

"Supertab completion
Plug 'ervandew/supertab'

" Fuzzy finder (:FZF)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', { 'depends': 'fzf' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Ack/ag file search
Plug 'mileszs/ack.vim'
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case --ignore-file .git -g ""'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack
cnoreabbrev rg Ack
cnoreabbrev rG Ack
cnoreabbrev Rg Ack
cnoreabbrev RG Ack

" neoformatter
Plug 'sbdchd/neoformat'
let g:neoformat_try_formatprg = 1
autocmd FileType javascript setlocal formatprg=npm\ run\ -s\ prettier

" NERDTreeToggle
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
map <C-\> :NERDTreeToggle<CR>

" NERDCommenter
Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1

" Git gutter highlighting
Plug 'airblade/vim-gitgutter'

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Cool lightweight status bar
Plug 'shinchu/lightline-gruvbox.vim'
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }
Plug 'itchyny/lightline.vim'

" Sublime-like multiple cursors
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
Plug 'terryma/vim-multiple-cursors'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NEO VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
  if has('clipboard') && (executable('pbcopy') || executable('xclip') || executable('xsel'))
    set clipboard+=unnamedplus "Use system clipboard
  endif
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of command history VIM will remember
set history=100

" Enable filetype plugins
filetype off
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on
set undolevels=100

" Sets time (ms) for vim to update gui (useful for gitgutter)
set updatetime=250

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable mouse support
set mouse=a


" Turn on the ruler (bar which indicates cursor position)
set ruler

" Fix backspace to behave like a bunch of other apps
set backspace=2

" Turn on line numbers
set number

" Highlinght search results
set hlsearch

" Incremental search refines search as you type
set incsearch

" Makes working with Regexs easier
set magic

" Show matching brackets
set showmatch

"How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $COLORTERM == 'truecolor'
  set t_Co=256
endif

" Highlight 80 character soft limit
"if exists('+colorcolumn')
"  set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif


" Set colorscheme
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='hard'
silent! colorscheme gruvbox
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Swap file directory -- prevent from polluting active directory
set backup
set wb
set swapfile

silent !mkdir ~/.tmp/vim/swp > /dev/null 2>&1
silent !mkdir ~/.tmp/vim/backup > /dev/null 2>&1

set directory=~/.tmp/vim/swp//
set backupdir=~/.tmp/vim/backup//


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Smart indent
set si

" Auto indent
set ai

" Wrap lines
set wrap


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" BEFORE SAVE
" Remove unwanted trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Runtime toggle prettier/neoformat
function! ToggleNeoformat()
    if !exists('#fmt#BufWritePre')
        augroup fmt
          autocmd!
          autocmd BufWritePre * silent Neoformat
        augroup END
    else
        augroup fmt
          autocmd!
        augroup END
    endif
endfunction

" Prettier/neoformat
augroup fmt
  autocmd!
  autocmd BufWritePre * silent Neoformat
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hotkeys/Keymaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
nnoremap <leader>R :Tags<cr>
nnoremap <leader>r :BTags<cr>
nnoremap <leader>D :Lines<cr>
nnoremap <Space> :BLines<cr>
nnoremap <C-p> :call fzf#vim#gitfiles('', fzf#vim#with_preview('right'))<cr>
nnoremap <C-F> :Buffers<cr>

" Ack search
nnoremap <leader>/ :Ack!<space>""<left>

" Search selection
vnoremap // y/\V<C-R>"<CR>

" Make shift up+down more reasonable...
nmap <S-Up> 5k
nmap <S-Down> 5j
" these are mapped in visual mode
vmap <S-Up> 5k
vmap <S-Down> 5j

" H+L go to start/end of line
noremap H ^
noremap L g_
