set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set rtp+=/usr/local/opt/fzf

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Clojure
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'tpope/vim-fireplace'
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-salve'

" Ag
" Plugin 'ag.vim'


" Go
Plugin 'fatih/vim-go'

"Mundo
Plugin 'simnalamburt/vim-mundo'

" Haskell
Plugin 'itchyny/vim-haskell-indent' 
Plugin 'adinapoli/cumino' 
Plugin 'bitc/vim-hdevtools' 
Plugin 'eagletmt/ghcmod-vim' 
Plugin 'neovimhaskell/haskell-vim'

" Html
Plugin 'mattn/emmet-vim'

" Javascript
Plugin 'jelera/vim-javascript-syntax'
Plugin 'moll/vim-node'

" Ide stuff
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'roman/golden-ratio'
Plugin 'sickill/vim-pasta'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'rking/ag.vim'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'flazz/vim-colorschemes'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-abolish'
Plugin 'airblade/vim-gitgutter'
Plugin 'gregsexton/gitv'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlp.vim' 
Plugin 'scrooloose/nerdtree'
Plugin 'wincent/ferret'

" Purescript
Plugin 'raichoo/purescript-vim'
Plugin 'frigoeu/psc-ide-vim'

" Ruby 
Plugin 'tpope/vim-bundler'

" SQL
Plugin 'vim-scripts/dbext.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add all plugins before this
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on

" Mundo Settings
set undofile
set undodir=~/.vim/undo
nnoremap <F5> :MundoToggle<CR>


syntax on

" Tab settings
" set expandtab
" set tabstop=4
" set shiftwidth=4

" Smart searching
set ignorecase
set smartcase
" set incsearch
set hlsearch

" Show line numbers
set number

" Other settings
set omnifunc=syntaxcomplete#Complete " Omni completion
set completeopt=menuone
set confirm
set cmdheight=1
set splitright
set splitbelow
set autowriteall
set autoread
let g:airline_powerline_fonts=1
" set showmatch
set mat=2
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.gitignore,*/bower_components/*


let mapleader=",,"
let maplocalleader="\\"

" Syntastic Settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_purescript_checkers = ['pscide']

" Haskell Syntax settings
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:cabal_indent_section = 2

" Cumino Settings
let g:cumino_default_terminal = "urxvt"

" paul's snippet, random port per psc-ide
if !exists('g:psc_ide_server_port')
  let g:psc_ide_server_port = system('echo -n $[${RANDOM}%3000+4000]')
endif

"purescript settings
"let g:psc_ide_syntastic_mode = 2
"augroup Purescript
 "    autocmd!
  "   autocmd BufRead *.purs set filetype=purescript
    " autocmd FileType purescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
     "set ai "Auto indent
   "  set si "Smart indent
    " set wrap "Wrap lines
     
     
    " autocmd FileType purescript nmap gf :PgoToDefinition<CR>
     "autocmd FileType purescript nmap <leader>t :Ptype<CR>
   "  autocmd FileType purescript nmap <leader>s :PapplySuggestion<CR>
    " autocmd FileType purescript nmap <leader>a :PaddTypeAnnotation<CR>
    " autocmd FileType purescript nmap <leader>i :PimportIdentifier<CR>
    " autocmd FileType purescript nmap <leader>r :Pload<CR>
    " autocmd FileType purescript nmap <leader>p :Ppursuit<CR>
    " autocmd FileType purescript nmap <leader>c :PcaseSplit<CR>
    " autocmd FileType purescript nmap <leader>qd :PremoveImportQualifications<CR
    " autocmd FileType purescript nmap <leader>qa :PaddImportQualifications<CR>
 "augroup end

"Purescript
" let g:psc_ide_log_level = 0
let g:psc_ide_syntastic_mode = 1
let g:psc_ide_suggestions=1
au FileType purescript map <leader>t :Ptype<CR>
au FileType purescript nmap <leader>s :PapplySuggestion<CR>
au FileType purescript nmap <leader>p :Ppursuit<CR>
au FileType purescript nmap <leader>c :PcaseSplit<CR>
au FileType purescript nmap <leader>a :PaddTypeAnnotation<CR>
au FileType purescript nmap <leader>i :PimportIdentifier<CR>
au FileType purescript nmap <leader>r :Pload<CR>
au FileType purescript nmap <leader>qd :PremoveImportQualifications<CR>
au FileType purescript nmap <leader>qa :PaddImportQualifications<CR>
nmap <leader>g <C-]>
au FileType purescript nmap <leader>g :PgoToDefinition<CR>

au FileType purescript set foldmethod=expr
au FileType purescript nmap <leader>fm :set foldmethod=manual<CR>zE<CR>
au FileType purescript nmap <leader>fe :set foldmethod=expr<CR>
au FileType purescript setlocal foldexpr=PureScriptFoldLevel(v:lnum)
" " let g:psc_ide_server_port = 3030
"
" "au FileType purescript set conceallevel=1
" "au FileType purescript set concealcursor=nvc
" "au FileType purescript syn keyword purescriptForall forall conceal cchar=∀ 
" "let g:psc_ide_syntastic_mode = 1
"
 function! PureScriptFoldLevel(l)
   return getline(a:l) =~ "^\d*import"
 endfunction


augroup RainbowParens
    autocmd!
    autocmd vimenter * RainbowParenthesesToggle
    autocmd syntax * RainbowParenthesesLoadRound
    autocmd syntax * RainbowParenthesesLoadSquare
    autocmd syntax * RainbowParenthesesLoadBraces
augroup end

augroup AutoSave
        autocmd!
        autocmd BufLeave,FocusLost * silent! w
augroup end

" Ghcmod settings
map <silent> tu :call GHC_BrowseAll()<CR>
map <silent> tw :call GHC_ShowType(1)<CR>

set background=light
" colorscheme smyck
" set mouse click for tab
set mouse=a
" map to complete already entered line
imap <c-x><c-l> <plug>(fzf-complete-line)

" to go to same line of file opened before
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal g`\"" |
       \ endif
augroup END

"for git commit 
augroup gitCommitEditMsg
   autocmd!
   autocmd BufReadPost *
     \ if @% == '.git/COMMIT_EDITMSG' |
     \   exe "normal gg" |
     \ endif
augroup END

"clear search after enter
:nnoremap <CR> :nohlsearch<cr>
