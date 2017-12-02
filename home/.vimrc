" Trying some settings as per Harry Roberts’ .vimrc
" https://github.com/csswizardry/dotfiles/blob/master/.vimrc

set encoding=utf-8

" Enable syntax highlighting
syntax on

color dracula

" Show matching parens, brackets, etc.
set showmatch

" Italicised comments and attributes
highlight Comment cterm=italic
highlight htmlArg cterm=italic

" Set relevant filetypes
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Don't offer to open certain files/directories
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,_site/*



" Text management

filetype plugin indent on
" Indent by 2 spaces
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
" Round indent to nearest multiple of 2
set shiftround

" Underscores denote words
set iskeyword-=_



" Interactions

" Start scrolling slightly before the cursor reaches an edge
set scrolloff=3
set sidescrolloff=5
" Scroll sideways a character at a time, rather than a screen at a time
set sidescroll=1
" Allow motions and back-spacing over line-endings etc.
set backspace=indent,eol,start
set whichwrap=h,l,b,<,>,~,[,]



" Search

" Don't keep results highlighted after searching...
set nohlsearch
" ...just highlight as we type
set incsearch
" Ignore case when searching...
set ignorecase
" ...except if we input a capital letter
set smartcase



" Visual decorations

" Show what mode you're currently in
set showmode
" Show what commands you're typing
set showcmd
" Show current line and column position in file
set ruler
" Show file title in terminal tab
set title
" Show invisibles
set list
set listchars=tab:»-,trail:·
