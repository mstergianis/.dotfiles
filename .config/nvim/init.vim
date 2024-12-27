let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'dag/vim-fish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'theRealCarneiro/hyprland-vim-syntax'
call plug#end()

syntax enable
filetype plugin indent on

set number
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell

nmap ,f :w<cr>:!gofmt -w %<cr><cr>

set ignorecase
set smartcase

colorscheme catppuccin-macchiato

" change the leader key to spacebar
nnoremap <SPACE> <Nop>
let mapleader = " "

" FZF shortcut
nnoremap <silent> <leader>ff :Files .<CR>
nnoremap <silent> <leader>pf :GitFiles<CR>
nnoremap <silent> <leader>fw :Files ~/workspace<CR>

" edit vim config
nnoremap <silent> <leader>fed :e ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>fef :e ~/.config/omf/init.fish<CR>
nnoremap <silent> <leader>fer :so ~/.config/nvim/init.vim<CR>

" window movements
nnoremap <silent> <leader>wj :wincmd j<CR>
nnoremap <silent> <leader>wk :wincmd k<CR>
nnoremap <silent> <leader>wh :wincmd h<CR>
nnoremap <silent> <leader>wl :wincmd l<CR>
nnoremap <silent> <leader>wv :wincmd v<CR>
nnoremap <silent> <leader>ws :wincmd s<CR>
nnoremap <silent> <leader>wd :wincmd c<CR>

" buffer close
nnoremap <silent> <leader>bd :bdelete<CR>

nnoremap <C-g> <ESC>
