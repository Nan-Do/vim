let mapleader = " "

" Manage plugins
call plug#begin('~/.vim/plugged')

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plug 'w0rp/ale'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'ervandew/supertab'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'jiangmiao/auto-pairs'
Plug 'Rip-Rip/clang_complete'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-rhubarb'
Plug 'szw/vim-maximizer'
Plug 'vim-scripts/taglist.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'lervag/vimtex'

" Color schemes
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jnurmine/zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'dracula/vim'

call plug#end()

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Easy navigation between tabs
" This mapping conflicts with jedi vim
" map <Leader>n <Esc>:tabprevious<CR>
map <Leader>u <Esc>:tabprevious<CR>
map <Leader>i <Esc>:tabnext<CR>

" Option to store all the swapfiles in the same directory
set directory=$HOME/.vim/swapfiles/

set nu
set encoding=utf-8

" Enable folding
set foldmethod=indent
set foldlevel=99

map <leader>f za<CR>

" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
hi MatchParen ctermbg=blue
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

" Some useful key combinations
:imap jk <Esc>
:vmap jk <Esc>
noremap <Leader>s :update<CR>
noremap <Leader>e :quit<CR>
noremap <Leader>E :qa!<CR>

" Remap keys to easily resize splits as in tmux
nnoremap <C-up> <C-W>+
nnoremap <C-down> <C-W>-
nnoremap <C-left> <C-W><
nnoremap <C-right> <C-W>>

" Make vim work properly when executed on tmux (nvim works properly)
if &term =~ '^screen'
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Remap changing the mode on the terminal
if has("nvim")
    " :tnoremap <Esc> <C-\><C-n>
    " :tnoremap jk <C-\><C-n>
    :tnoremap qq <C-\><C-n>
endif

" Autoclose the documentation window when choosing an option
autocmd CompleteDone * pclose

" NERDTree options
map <leader>t :NERDTreeToggle<CR>

" Ale options
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
" Set flake to use python 2
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_options = '-m flake8'

" Sort
vnoremap <Leader>s :sort<CR>

" Easier move of blocks
" vnoremap < <gv
" vnoremap > >gv

" Make the mouse work
set mouse=a
" Let copy and past to other apps
set clipboard=unnamed

" =======[ Make the 81st column stand out ]===========
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Option to work properly with tmux
" set term=screen-256color

" Set the color theme if the terminal supports 256 colors
if &t_Co == 256 || has('gui_running')
    " Set the background to dark, and which scheme to use.
    set background=dark
    colors hybrid_material
else
    colors peachpuff
endif

if has("nvim")
    set termguicolors
endif


" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

"let g:EclimCompletionMethod = 'omnifunc'

" Snippets configurarion
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#complete_method = 'completefunc'

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" Let <Tab> also do completion
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"             \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
      set conceallevel=2 concealcursor=niv
endif

" For java autocompletion
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type leader<h> to toggle highlighting on/off.
nnoremap <leader>h :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=500
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction

" Jedi-vim options
"let g:jedi#use_splits_not_buffers = "right"
let g:jedi#use_tabs_not_buffers = 1
autocmd FileType python setlocal completeopt-=preview

" Set the relative and numering on
set number
" set relativenumber

" Configuration for the c/c++ autocompletion
"let g:clang_library_path='/usr/lib/llvm-4.0/lib'
let g:clang_library_path=''

" Powerline options
let g:airline_powerline_fonts = 1

" Remove autopairs incompatibility
let g:AutoPairsMapCR = 0

" Options for the tags plugin
let Tlist_Use_Right_Window = 1
nnoremap <Leader>y :TlistToggle<CR>

" Key shortcut for the maximizer plugin
nnoremap <Leader>o :MaximizerToggle<CR>

" Set the options to set Gdiff on a vertical window with filler lines
set diffopt+=vertical,filler

" key shortcut for pastemode
set pastetoggle=<F2>

" Let nerdtree know that we dont want to show pyc files
let NERDTreeIgnore = ['\.pyc$']

" Show the pressed key on the status bar (by default on nvim)
set showcmd

" Update the highlighting of the last search
nnoremap <leader>l :nohl<CR>
