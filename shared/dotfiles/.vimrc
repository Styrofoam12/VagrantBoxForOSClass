"--- _vimrc

" Can be used to detect GUI when necessary
"if has('gui_running')
"endif

let mapleader=","

" Vim compatiblity and filetype handling
set nocompatible
set fileformat=unix
syntax on
filetype on
filetype plugin on
filetype indent on

" http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=1000
set wildmenu
set title
runtime macros/matchit.vim

" intelligent backspace
set backspace=indent,eol,start

" backspace and cursor keys wrap to previous/next line
"set whichwrap+=<,>,h,l,[,]

" highlight search terms
set hlsearch
set incsearch
map <C-\> :nohlsearch<CR>

" turn off the bell
"set visualbell

" set text sizes for source code editing
set softtabstop=2
set tabstop=2
set shiftwidth=2
set textwidth=0 " unlimited

" set text behavior
set nolist
set number
set autoindent
set showmatch
set showmode
set nowrap
set expandtab

" set better cursor context
set scrolloff=3
set cursorline
set nocursorcolumn

" set color scheme
if has('gui_running')
  colors murphy
else
  colors darkZ
endif

" set the font
" use ':set gfn?' in gVim to see the current font
if has("mac")
  set guifont=Inconsolata:h18.00
elseif has("unix")
  set guifont=Inconsolata\ Medium\ 14
elseif has("win32")
  set guifont=Lucida_Console:h12
else
  set guifont=Inconsolata:h18.00
endif

" setup spell checker
set spell spl=en_us " Select language
set nospell " Turn it off at start

" set hotkeys for plugins
nnoremap <silent> <F4> :YRShow<CR>
nnoremap <silent> <F5> :BufExplorer<CR>
nnoremap <silent> <F6> :Explore<CR><CR>
nnoremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <F8> :UndotreeToggle<cr>
nnoremap <silent> <F9> :<C-F>

" other command shortcuts
command E Explore
noremap Y y$
" force write a file as sudo
ca w!! w !sudo tee "%"

" movement between splits
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" setup status line
if has("win32")
  set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]
else
  set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]
  "set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [POS=%04l,%04v][%p%%]\ [LEN=%L]\ [FORMAT=%{&ff}]
end
set laststatus=2

" setup tab key for navigating between buffers
"set autochdir
map <Tab> <C-W>W:cd %:p:h<CR>:<CR>

" setup the NERD_tree plugin
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeCaseSensitiveSort=0
let NERDTreeChDirMode=1
let NERDTreeHighlightCursorline=1
let NERDTreeQuitOnOpen=0

" enable and configure persistent undo
if has("persistent_undo")
  set undodir='~/.undodir/'
  set undofile
endif

" settings for Vimerl
let erlang_show_errors = 0

"if has("win32")
"  let erlang_show_errors = 0
"else
"  let erlang_show_errors = 1
"endif

" settings for various file types
au BufRead,BufNewFile {*.R} set ft=R
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.md set filetype=markdown
autocmd BufNewFile,BufRead,BufReadPre *.tex set filetype=tex
autocmd BufNewFile,BufRead,BufReadPre *.tex set wrap

" settings for Ruby files
au BufRead,BufNewFile {Capfile,.caprc} set ft=ruby
au BufRead,BufNewFile Gemfile set ft=ruby
au BufRead,BufNewFile Rakefile set ft=ruby
au BufRead,BufNewFile Thorfile set ft=ruby
au BufRead,BufNewFile config.ru set ft=ruby
au BufRead,BufNewFile {.irbrc,irb_tempfile*} set ft=ruby

" settings for text files
autocmd BufNewFile,BufReadPre *.txt set textwidth=80
autocmd BufNewFile,BufReadPre *.txt set spell spl=en_us
autocmd BufNewFile,BufReadPre *.txt set number
autocmd BufNewFile,BufReadPre *.txt let g:autoclose_on=1

" Windows-like clipboard behavior
" http://superuser.com/questions/10588/how-to-make-cut-copy-paste-in-gvim-on-ubuntu-work-with-ctrlx-ctrlc-ctrlv
if has('gui_running')
  " CTRL-X and SHIFT-Del are Cut
  vnoremap <C-X> "+x
  vnoremap <S-Del> "+x
  " CTRL-C and CTRL-Insert are Copy
  vnoremap <C-C> "+y
  vnoremap <C-Insert> "+y
  " CTRL-V and SHIFT-Insert are Paste
  map <C-V>		"+gP
  map <S-Insert>		"+gP
  cmap <C-V>		<C-R>+
  cmap <S-Insert>		<C-R>+
  " Use CTRL-Q to do what CTRL-V used to do
  noremap <C-Q>		<C-V>
endif
