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
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
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
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-rhubarb'

call plug#end()

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Easy navigation between tabs
" This mapping conflicts with jedi vim
" map <Leader>n <Esc>:tabprevious<CR>
map <Leader>b <Esc>:tabprevious<CR>
map <Leader>m <Esc>:tabnext<CR>

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
" Remap changing the mode on the terminal
if has("nvim")
    :tnoremap <Esc> <C-\><C-n>
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
vnoremap < <gv
vnoremap > >gv

" Make the mouse work
set mouse=a
" Let copy and past to other apps
set clipboard=unnamed

" =======[ Make the 81st column stand out ]===========
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Set the color theme if the terminal supports 256 colors
if &t_Co == 256 || has('gui_running')
    " Set the background to dark, and which scheme to use.
    set background=dark
    colors zenburn "delek desert, koehler, pablo, slate, torte...kk
else
    colors peachpuff
endif

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

"let g:EclimCompletionMethod = 'omnifunc'

" Snippets configurarion
let g:deoplete#enable_at_startup = 1
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
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

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
set relativenumber

" Configuration for the c/c++ autocompletion
"let g:clang_library_path='/usr/lib/llvm-4.0/lib'
let g:clang_library_path='/usr/lib/llvm-4.0/lib/libclang-4.0.1.so'

" Powerline options
let g:airline_powerline_fonts = 1

" Remove autopairs incompatibility
let g:AutoPairsMapCR = 0
