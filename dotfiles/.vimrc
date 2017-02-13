" =========================================================================== "
"                                   PLUGINS                                   "
" =========================================================================== "

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle do his stuff alone
Plugin 'gmarik/Vundle.vim'

" airblade : gitgutter - +/- for Git
Plugin 'airblade/vim-gitgutter'

" bling : airline - Bottom bar
Plugin 'bling/vim-airline'

" Valloric : YouCompleteMe - Autocompletion
Plugin 'Valloric/YouCompleteMe'

" vivien : linux-conding-style - setup for linux dev
Plugin 'vivien/vim-linux-coding-style'

call vundle#end()
filetype plugin indent on

" =========================================================================== "
"                                CONFIGURATIONS                               "
" =========================================================================== "

syntax on
set history=700
set number
set background=dark
set t_Co=256
colorscheme distinguished

" Highlight the current line
set cursorline
" A buffer can be hidden
set hidden
" Use Unix as the standard file type
set ffs=unix
set encoding=utf8
" Fix backspace key
set backspace=indent,eol,start
" Move to previous/next line with left, right
set whichwrap+=<,>,h,l
" Activate the mouse
set mouse=a
" Turn off backup and swap
set nobackup
set nowb
set noswapfile
" Set red line
set cc=80,100

" Use spaces instead of tabs
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Auto indent
set ai
" Smart indent
set si
" Wrap lines
set wrap
" Linebreak on 500 characters
set lbr
set tw=500
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" Turn on the Wild menu
set wildmenu
"Always show current position
set ruler
" Height of the command bar
set cmdheight=2
" A buffer becomes hidden when it is abandoned
set hid
" Remember info about open buffers on close
set viminfo^=%
" Always show the status line
set laststatus=2
" Change invisible character when :set list
set listchars=eol:¬
" Do listchars replacement
"set list

" Try to create undofiles in ${HOME}/.vim/.undo
try
    set undodir=~/.vim/undo
    set undofile
catch
endtry

" Delete trailing white space on save
func! DeleteTrailingWS()
    if exists('b:noDeleteTraillingWS')
        return
    endif
    %s/\s\+$//ge
endfunc
autocmd BufWritePre * :call DeleteTrailingWS()

augroup mail_netiquette
    autocmd!
    autocmd FileType mail let b:noDeleteTraillingWS=1
    autocmd FileType mail setlocal cc=72 tw=70 list
augroup END

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Indent/Unindent in visual mode
vmap <Tab> >
vmap <S-Tab> <
