"---- _gvimrc

" set the screen size
set lines=60
set columns=160

" set hotkeys for tab navigation
map <C-t> :tabnew<CR>
map <C-left> :tabp<CR>
map <C-right> :tabn<CR>

" change to my most common working directory
if has("mac")
	:silent cd $HOME/Projects
elseif has("unix")
	:silent cd $HOME/Projects
elseif has("win32")
	:silent cd $HOME/Projects
endif

set vb t_vb=
