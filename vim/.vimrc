" vim configuration
" ---------------------------------------------------------------------

" Variables
" ---------------------------------------------------------------------
" set vimrc location
if has ('unix')
  let vimrc='~/.vimrc'
elseif has ('windows')
  let vimrc='$VIM\_vimrc'
endif

" General
" ---------------------------------------------------------------------
" vim and no vi
set nocompatible
" use backup file
set backup
" Security, ignore lines (at start and end) for initializations
set modelines=0
" Encoding
set encoding=utf-8
" Allow hidden buffers
set hidden
" Rendering
set ttyfast
" history size
set history=1000
" Automaticly reread outside changed file (if not touched inside)
set autoread
" autowrite for special operations
set autowrite

" User Interface - appearance
" ---------------------------------------------------------------------
" Show line numbers
set number
"set relativenumber
" highlight current line
set cursorline
" display the status line
set laststatus=2
" display the cursor position (last line, status line, title bar)
set ruler
" Last line
set showmode
set showcmd
"Use colors that suit a dark background
set background=dark

" --- Terminal specific settings ---
if &t_Co > 2
  " Turn on syntax highlighting
  syntax on

  " Color scheme
  colorscheme monokai
  "colorscheme solarized8
  "colorscheme solarized8_flat
  "colorscheme gruvbox
  
  set termguicolors

  " search pattern highlighting
  set hlsearch
  " no background for transparent terminal
  hi Normal ctermbg=NONE guibg=NONE
  hi NonText ctermbg=NONE guibg=NONE
  hi LineNr ctermbg=NONE guibg=NONE

  " split bar style
  set fillchars=vert:┊ 
  hi vertsplit ctermfg=239 ctermbg=NONE
endif

" --- Gui specific settings ---
if has("gui_running")
  " Turn on syntax highlighting
  syntax on
  " Color scheme
  try
    colorscheme monokai
"    colorscheme solarized
  catch
    colorscheme desert
  endtry
"  set guifont=Menlo-Regular:h13
  set guifont=Source\ Code\ Pro:h15
  set hlsearch
  set wrap
  set guioptions-=m                     " Hide the menubar
  set guioptions-=T                     " Do not display the Toolbar
  set guioptions-=b                     " Do not display the bottom scrollbar
  set guioptions-=r                     " Do not display the right scrollbar
  set guioptions-=L                     " Do not display the left scrollbar
endif

" User Interface - behavior
" ---------------------------------------------------------------------
" Blink cursor on error instead of beeping
set visualbell
" Jumps to opening brace
set showmatch
" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
"runtime! macros/matchit.vim

" Text Rendering
" ---------------------------------------------------------------------
" no line wrap
set nowrap
" Whitespace
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab " spaces instead of tabs
set noshiftround

" Comments
" ---------------------------------------------------------------------
" automatic formating
set formatoptions=croq
" automagic multi-line comments
set comments=sl:/*,mb:**,elx:*/

" Indention
" ---------------------------------------------------------------------
" automatic indention
set cindent
if has("autocmd")
  filetype plugin indent on
else
  set autoindent
endif

" Code Folding
" ---------------------------------------------------------------------
set foldenable
"? set foldmethod=marker
"set foldmarker="{{{,}}}"

" Spell checking
" ---------------------------------------------------------------------
set nospell
set spelllang=de,en

" Search
" ---------------------------------------------------------------------
" Enable search highlighting.
set hlsearch
" Ignore case when searching
set ignorecase
" Incremental search that shows partial matches
set incsearch
" Automatically switch search to case-sensitive when search query contains an uppercase letter
set smartcase

" Key bindings
" ---------------------------------------------------------------------
" set leader key
let mapleader = " "

" --- normal mode ---
" clear search highlighting
nnoremap <Esc><Esc> :noh<cr>
" select all
nnoremap <C-a> gg<S-v>G
" Split window
nnoremap ss :split<Return><C-w>w
nnoremap sv :vsplit<Return><C-w>w
" switch window
nnoremap <Leader><Tab> <C-w>w
nnoremap sh <C-w>h
nnoremap sk <C-w>k
nnoremap sj <C-w>j
nnoremap sl <C-w>l
" open explorer
nnoremap <Leader>e :Lexplore<Cr>
"nnoremap <Leader>e :NERDTreeToggle<Cr>
" search and replace template for the current word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" --- insert mode ---
" also `jj` for <Esc>
inoremap jj <Esc>
" let `<C-c>` act like `<Esc>`
inoremap <C-c> <Esc>

" --- visual mode ---
" move highlight line down / up
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" repeat indent
vnoremap < <gv
vnoremap > >gv

" --- F-Keys ---
" execute make
"nmap <F5> :make<CR>
" show next error
"nmap <F6> :cn<CR>
" show prev error
"nmap <F7> :cp<CR>
" toggle line numbers
nmap <F8> :set relativenumber!<CR>
" toggle relative eine numbers
nmap <F9> :set number!<CR>
" toggle spell checking
nmap <F10> :set spell!<CR> 

" Auto command
" ---------------------------------------------------------------------
if has("autocmd")
  " open file on last edit position
  augroup lastEditPosition
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
  augroup END

  " source .zshrc on save
  augroup sourceConfig
    autocmd!
    autocmd BufWritePost ~/.vimrc so ~/.vimrc
    autocmd BufWritePost .vimrc so ~/.vimrc
  augroup END
else
  set autoindent
endif

" Functions and new commands
" ---------------------------------------------------------------------
" special hardcopy (print) color scheme
function UseMyHardcopyColors(args)
  " only gui (TODO)
  if !has("gui_running")
    exec 'hardcopy '.a:args
  else
    " save current colors
    let save_bg=&bg
    let save_cs=g:colors_name
    " set new colors
    set bg=light
    colorscheme solarized
    " call hardcopy
    exec 'hardcopy '.a:args
    " reset colors
    exec 'set bg='.save_bg
    exec 'colorscheme '.save_cs
  endif
endfunction

" set new command Hardcopy
command! -nargs=* Hardcopy call UseMyHardcopyColors('<args>')

