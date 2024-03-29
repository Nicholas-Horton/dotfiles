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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NEO VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors

  if has('clipboard') && (executable('pbcopy') || executable('xclip') || executable('xsel'))
    set clipboard+=unnamedplus "Use system clipboard
  endif

  " Preview substititions
  " nosplit also works
  set inccommand=split

else
  set ttymouse=xterm2
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

" DEPENDS
" LSP
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" SYNTAX HIGHLIGHTING
" Rust
Plug 'rust-lang/rust.vim'

" Go
let g:go_fmt_command = "goimports"
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Typescript
Plug 'leafgarland/typescript-vim'

" Vue
Plug 'posva/vim-vue'

" Coffeescript
Plug 'https://github.com/kchmck/vim-coffee-script.git'

" Handlebars
Plug 'mustache/vim-mustache-handlebars'

" CSS3/SASS (scss)
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

" Better JS
Plug 'pangloss/vim-javascript'

" TPOPE
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dadbod'

" Distraction free mode
Plug 'junegunn/goyo.vim'

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
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_sign_column='bg0'
Plug 'morhetz/gruvbox'

" Airline
" ale
let g:airline#extensions#ale#enabled = 1

let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 0 " hide tab number
let g:airline#extensions#tabline#show_tab_type = 0 " Hide tab type indicator
let g:airline#extensions#tabline#show_buffers = 0
let airline#extensions#tabline#show_splits = 0
" configure the minimum number of tabs needed to show the tabline.
let g:airline#extensions#tabline#tab_min_count = 2

let g:airline_skip_empty_sections = 1
let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
let g:airline_section_c = '%<%<%{airline#extensions#fugitiveline#bufname()}%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline_section_x = '%{airline#util#prepend("",0)}%{airline#util#prepend("",0)}%{airline#util#wrap(airline#parts#filetype(),0)}'
let g:airline_section_y = ''
let g:airline_section_z = '%#__accent_bold#%4l/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%3v'

Plug 'vim-airline/vim-airline'

" Sublime-like multiple cursors
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
Plug 'terryma/vim-multiple-cursors'

" Seamless pane navigation, within tmux
let g:tmux_navigator_no_mappings = 1
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of command history VIM will remember
set history=10000

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

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Allow moving away from a buffer without saving
set hidden

" COC
" Don't pass messages  to |ins-completion-menu|
set shortmess+=c

" Always shows sign column
set signcolumn=yes

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $COLORTERM == 'truecolor'
  set t_Co=256
endif

" Set colorscheme
silent! colorscheme gruvbox
set background=dark

"set cursorline
"hi CursorLine guibg=#282828

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Hide trailing tilde on empty lines at end of file
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

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

" Auto indent
set ai

" Wrap lines
set wrap


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Auto commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" BEFORE SAVE
" Remove unwanted trailing spaces
"autocmd BufWritePre * %s/\s\+$//e
function! StripWhitespace()
  let _s=@/
  %s/\s\+$//e
  let @/=_s
endfunction

autocmd BufWritePre * call StripWhitespace()

augroup todo_syntax
 au!
 au Syntax * syn match ToDoComments /\v<(FIXME|NOTE|TODO|OPTIMIZE|HACK):/
       \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link ToDoComments Todo

" Prevent syntax highlighting for vue messing up
autocmd FileType vue syntax sync fromstart

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Hotkeys/Keymaps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Pairing
inoremap {<Space> {  }<Left><Left>
inoremap {<CR>    {<CR>}<Esc>O
inoremap {{       {
inoremap {}       {}

" FZF
nnoremap <C-Space> :BTags<cr>
nnoremap <Space> :BLines<cr>
nnoremap <C-g> :GFiles?<cr>
nnoremap <C-p> :FZF<cr>
nnoremap <C-f> :Buffers<cr>

" Ack search
nnoremap <leader>/ :Ack!<space>""<left>
vnoremap <leader>/ "sy:Ack!<space>"<C-R>""<left>

" Search selection
vnoremap // y/\V<C-R>"<CR>

" Make up+down motion more reasonable...
nmap <C-k> 5k
nmap <C-j> 5j
vmap <C-k> 5k
vmap <C-j> 5j

" Make left+right motion more reasonable...
nmap <C-h> ^
nmap <C-l> g_
vmap <C-h> ^
vmap <C-l> g_
imap <C-h> <c-o>^
imap <C-l> <c-o>g_

" LSP - COC -----------------------------------------------
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <c-j> coc#pum#visible() ? coc#pum#next(1) : "\<c-j>"
inoremap <expr> <c-k> coc#pum#visible() ? coc#pum#prev(1) : "\<c-k>"

nmap <silent> gd :call CocAction('doHover')<CR>
nmap <silent> gD <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <leader>rn <Plug>(coc-rename)

nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" ---------------------------------------------------------

" Seamless tmux navigation
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>

" Remove mild annoyances
nnoremap Q <Nop>
map q: <Nop>

" Go debugging
nnoremap <leader>yf :let @+=expand("%") . ":" . line(".")<cr>
