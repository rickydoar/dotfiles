syntax on
set t_Co=256
colorscheme darkburn 
 
set modeline
set autoindent
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number

set mouse=a

"""" Movement
" work more logically with wrapped lines
noremap j gj
noremap k gk

"""" Searching and Patterns
set ignorecase							" search is case insensitive
set smartcase							" search case sensitive if caps on 
set incsearch							" show best match so far
set hlsearch							" Highlight matches to the search 
"""" Messages, Info, Status
set shortmess+=a						" Use [+] [RO] [w] for modified, read-only, modified
set showcmd								" Display what command is waiting for an operator
set ruler								" Show pos below the win if there's no status line
set laststatus=2						" Always show statusline, even if only 1 window
set report=0							" Notify me whenever any lines have changed
set confirm								" Y-N-C prompt if closing with unsaved changes
set vb t_vb=							" Disable visual bell!  I hate that flashing.

"""" Editing
set backspace=2							" Backspace over anything! (Super backspace!)
set showmatch							" Briefly jump to the previous matching paren
set matchtime=2							" For .2 seconds
set formatoptions-=tc					" I can format for myself, thank you very much
set tabstop=4							" Tab stop of 4
set shiftwidth=4						" sw 4 spaces (used on auto indent)
set softtabstop=4						" 4 spaces as a tab for bs/del
set expandtab

"""" Coding
set history=100							" 100 Lines of history
set showfulltag							" Show more information while completing tags
filetype plugin on						" Enable filetype plugins
filetype plugin indent on				" Let filetype plugins indent for me
syntax enable								" Turn on syntax highlighting

" we don't want to edit these type of files
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp
 
" autocmd filetype html setlocal noexpandtab tabstop=2 softtabstop=2 shiftwidth=2
" autocmd filetype css setlocal noexpandtab tabstop=2 softtabstop=2 shiftwidth=2
 
let python_highlight_all=1
let python_slow_sync=1

"Set swp files to go to a central location
set backupdir=$HOME/.vim/swp//,/tmp
set directory=$HOME/.vim/swp//,/tmp

map <C-h> :tabp<CR>
map <C-l> :tabn<CR>
map :tn :tabnew

cmap rmw %s/\s\+$//g
