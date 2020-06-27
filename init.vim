call plug#begin('~/AppData/Local/nvim-data/plugged')

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Emmet
Plug 'mattn/emmet-vim'

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

" Font
set guifont=Consolas:h13:cANSI:qDRAFT



" ColorScheme
source C:/users/pedro/AppData/Local/nvim/colorscheme.vim
" COC Config
source C:/users/pedro/AppData/Local/nvim/coc.vim
" My Maps
source C:/users/pedro/AppData/Local/nvim/mymaps.vim
" Emmet
source C:/users/pedro/AppData/Local/nvim/emmet.vim
