set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set nofoldenable
set inccommand=split
set mouse=a
set number
set title
set ttimeoutlen=0
set wildmenu
set expandtab
set shiftwidth=2
set tabstop=2
filetype plugin indent on
syntax on
set t_Co=256
set termguicolors

call plug#begin()
    Plug 'ryanoasis/vim-devicons'
    Plug 'plasticboy/vim-markdown'
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdtree'
    Plug 'dracula/vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()

syntax enable
colorscheme dracula

let NERDTreeShowHidden=1
