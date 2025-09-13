" Windows Terminal Formatting
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"
let &t_ti ..= "\e[2 q"

if !isdirectory(expand("~/.vim/backup"))
    silent! call mkdir(expand("~/.vim/backup"), "p")
endif

if !isdirectory(expand("~/.vim/swap"))
    silent! call mkdir(expand("~/.vim/swap"), "p")
endif

if !isdirectory(expand("~/.vim/undo"))
    silent! call mkdir(expand("~/.vim/undo"), "p")
endif

" Swap file backup location
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Cosmetics
syntax enable
set relativenumber
set autoindent
set hlsearch
set ignorecase 
set ruler
"set termguicolors

" Remove highlighting
autocmd CursorMoved * set nohlsearch
nnoremap n n:set hlsearch<cr>
nnoremap N N:set hlsearch<cr>
