call plug#begin('~/AppData/Local/nvim-data/plugged')

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Emmet
Plug 'mattn/emmet-vim'

" JavaScript Support
Plug 'pangloss/vim-javascript'

" JSX Support
Plug 'mxw/vim-jsx', { 'for': ['jsx', 'javascript.jsx'] }

" TypeScript Syntax Highlight
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" TypeScript Indentation
Plug 'jason0x43/vim-js-indent'

" TypeScript Server & Completion
Plug 'Quramy/tsuquyomi'

" Surrounder for Simple Stuff
Plug 'tpope/vim-surround'

" Commenter
Plug 'tpope/vim-commentary'

" NERDTree
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" Linter & Formatter
Plug 'w0rp/ale'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" CtrlP - Quick open files
Plug 'ctrlpvim/ctrlp.vim'

" Vim Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ColorSchemes
Plug 'chriskempson/base16-vim'

call plug#end()



" NeoVim Preferences
set number
set relativenumber

set wrap
set linebreak

set incsearch

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

set backspace=2
set mouse=a

set encoding=utf-8
set fileformat=unix

set colorcolumn=81,121

set nocompatible
set autoread

set guifont=Droid_Sans_Mono_Slashed_for_Pow:h11:cANSI:qANTIALIASED


" ColorScheme
source C:/Users/Pedro/AppData/Local/nvim/colorscheme.vim
" COC Config
source C:/Users/Pedro/AppData/Local/nvim/coc.vim
" My Maps
source C:/Users/Pedro/AppData/Local/nvim/mymaps.vim
" Emmet
source C:/Users/Pedro/AppData/Local/nvim/emmet.vim
" TypeScript
source C:/Users/Pedro/AppData/Local/nvim/typescript.vim
" NERDTree
source C:/Users/Pedro/AppData/Local/nvim/nerd.vim
" Vim Airline
source C:/Users/Pedro/AppData/Local/nvim/vimairline.vim
" CtrlP
source C:/Users/Pedro/AppData/Local/nvim/ctrlp.vim
" Ale
source C:/Users/Pedro/AppData/Local/nvim/ale.vim
