"" Plugins
call plug#begin ('~/.vim/plugged')
"Plug 'dense-analysis/ale'
Plug 'Shougo/denite.nvim'
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'ericbn/vim-solarized'
Plug 'mattn/calendar-vim'
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'cloudhead/neovim-ghcid'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'sh install.sh',
    \ }
"Plug 'parsonsmatt/intero-neovim'
Plug 'Shougo/neomru.vim'
Plug 'FrigoEU/psc-ide-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-eunuch'
Plug 'takac/vim-hardtime'
Plug 'bitc/vim-hdevtools'
"Plug 'jpalardy/vim-slime'
Plug 'edkolev/tmuxline.vim'
"Plug 'kovisoft/slimv'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'clojure-vim/async-clj-omni'
Plug 'snoe/clojure-lsp'
Plug 'vim-scripts/VimClojure'
Plug 'snoe/vim-sexp'
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
"Plug 'dgrnbrg/vim-redl'
Plug 'clojure-vim/vim-cider'
"Plug 'vim-scripts/paredit.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'artur-shaik/vim-javacomplete2'
call plug#end()

let g:hardtime_default_on = 0
syntax on
filetype plugin indent on     " required!
filetype plugin on

let g:airline#extensions#tabline#enabled = 1

"set omnifunc=syntaxcomplete#Complete

set winminheight=0      " Allow windows to get fully squashed
let g:tex_flavor = "latex"
"let g:solarized_termcolors=256
let g:solarized_termtrans=1
set t_Co=256
set background=light
set cmdheight=1
set mouse=a
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
"set backspace=indent,eot
"set relativenumber
"set number
set ic
set autoindent
set cindent
set showmode
set ttyfast
set ruler
set showcmd                     " display incomplete commands
set showmatch
let mapleader = ","
nnoremap <silent> <leader><space> :noh<cr>
inoremap jk
inoremap <leader><space> <esc>
inoremap <esc> <nop>
set scrolloff=3
syntax enable
set ai
set history=300
set ul=50
set shiftwidth=2
set tabstop=2
set expandtab
set shiftround
set vb
noremap <silent> <f1> :bprev<CR>
noremap <silent> <f2> :bnext<CR>
inoremap <Esc>OP <esc>:w :bprev<CR>
inoremap <Esc>OQ <esc>:w :bprev<CR>
set hlsearch                " highlight all results
set incsearch               " but do highlight as you type your search.
set ignorecase              " make searches case-insensitive...
set smartcase               " ... unless they contain at least one capital letter
set gdefault " have :s///g flag by default on"
let g:gitgutter_highlight_linenrs = 1
autocmd VimEnter * if argc() == 0 | NERDTree | endif
let NERDTreeQuitOnOpen = 1  " Automatically close nerdtree on open a file
let NERDTreeAutoDeleteBuffer = 1 " Automatically delete the buffer of file deleted
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:LanguageClient_autoStart = 1

"Disable arrow keys. Getting used to hjkl
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
noremap <space> :

" Periodical auto-save
" Write to disk after 1 second of inactivity, once every 15 seconds.
"au BufRead,BufNewFile * let b:last_autosave=localtime()
"au CursorHold * call UpdateFile()
"au BufWritePre * let b:last_autosave=localtime()
"set updatetime=1000000
"function! UpdateFile()
    "if exists("b:last_autosave") && ((localtime() - b:last_autosave) >= 15)
      "update
      "let b:last_autosave=localtime()
    "endif
"endfunction

set shell=zsh
"nnoremap <silent> 99 :TagbarToggle<cr>
map <C-h> h
map <C-j> j
map <C-k> k
map <C-l> l
nnoremap ( 3<
nnoremap ) 3>

"set foldmethod=indent
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
set foldlevel=1
set foldnestmax=2

" Save the current buffer
set laststatus=2   " Always show the statusline

set clipboard+=unnamed  " Yanks go on clipboard instead.

autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType cucumber compiler cucumber | setl makeprg=cucumber\ \"%:p\"
autocmd FileType ruby
      \ if expand('%') =~# '_test\.rb$' |
      \   compiler rubyunit | setl makeprg=testrb\ \"%:p\" |
      \ elseif expand('%') =~# '_spec\.rb$' |
      \   compiler rspec | setl makeprg=rspec\ \"%:p\" |
      \ else |
      \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
      \ endif
autocmd User Bundler
      \ if &makeprg !~# 'bundle' | setl makeprg^=bundle\ exec\  | endif
"Rails shortcuts
"noremap <Leader>a :A
"noremap <Leader>r :.Rake!
"let $RAILS_ENV = 'test'
nnoremap <leader>c :%s/\s\+$//<cr>:let @/=''<CR>
"set fillchars+=stl:\ ,stlnc:\
set encoding=utf-8 " Necessary to show Unicode glyphs
set guifont=DroidSansMono\ Nerd\ Font:h11
"set noesckeys "After seeing this http://ksjoberg.com/vim-esckeys.html
hi Search cterm=NONE ctermfg=grey ctermbg=blue
highlight Pmenu ctermbg=238 gui=bold
"set cuc cul # Highlight columns! For when you're nested too deep, obviously.

set hidden "allow buffer switching without saving
"set autoread "auto reload if file saved externally
set showcmd
set modeline
set modelines=5

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*.jar
"
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Don't redraw while executing macros (good performance config)
set lazyredraw

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
" Remember info about open buffers on close
"set viminfo^=%
"set shada="NONE"

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.rb :call DeleteTrailingWS()
autocmd BufWrite *.nix :call DeleteTrailingWS()
autocmd BufWrite *.scala :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.jsx :call DeleteTrailingWS()
autocmd BufWrite *.hs :call DeleteTrailingWS()
autocmd BufWrite *.purs :call DeleteTrailingWS()
autocmd BufWrite .*rc :call DeleteTrailingWS()
autocmd BufWrite *.clj :call DeleteTrailingWS()
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

au FocusLost * :set number
au FocusGained * :set relativenumber

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
set relativenumber

let g:bufferline_rotate = 2
let g:bufferline_fname_mod = ':t:r'

set nobackup
set noswapfile
let g:airline_theme = 'bubblegum'
let g:airline#extensions#tmuxline#enabled = 0

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" bind K to grep word under cursor
nnoremap = :grep! "\b<C-R><C-W>\b"<CR>

" bind \ (backward slash) to grep shortcut
let g:ackprg = 'rg --vimgrep --no-heading'
nnoremap \ :Ack<SPACE>

" Bind <leader>y to forward last-yanked text to Clipper
nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>
let g:tmuxline_theme = 'iceberg'
let g:tmuxline_preset = {
      \'a'    : ['#S', '#P'],
      \'b'    : '#W',
      \'win'  : '#I #F',
      \'cwin' : '#I #F',
      \'y'    : ['%R', '%a', '%Y']}
set ttyfast lazyredraw
if !has('nvim')
  set ttymouse=xterm2 ttyscroll=3
endif

cmap w!! w !sudo tee % >/dev/null

"If you need to define a block in visual block mode with bounds outside the actual text (that is, past the end of lines), you can allow this with:
set virtualedit=block

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:hardtime_timeout = 3000
let g:hardtime_showmsg = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]
noremap <silent> <leader>ht :HardTimeToggle<CR>

"let g:indent_guides_enable_on_vim_startup = 0 "disable indent show on startup
""let g:indent_guides_default_mapping = 1
"let g:indent_guides_guide_size=1
"nmap <silent> <Leader>i <Plug>IndentGuidesToggle
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray ctermbg=0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=236

nnoremap g= mrgg=G`r " indent the whole file
nnoremap <silent> <leader>d :bdelete<CR>
"cmap bd <NOP>
"cmap q <NOP>
"cmap q! <NOP>
nnoremap zz ZZ
nnoremap zq ZQ
let b:javascript_fold = 1
let g:jsx_ext_required = 0
nnoremap J mzJ`z
if exists('$TMUX')
  nnoremap <silent> <Leader>z :call system("tmux resize-pane -Z")<CR>
endif

"clojure
let g:sexp_enable_insert_mode_mappings = 1
let g:clj_fmt_autosave = 1


au BufNewFile,BufRead *.purs set filetype=purescript
autocmd BufReadPost *.clj setlocal filetype=clojure
let g:purescript_indent_if = 3
let g:purescript_indent_case = 5
let g:purescript_indent_let = 4
let g:purescript_indent_where = 6
let g:purescript_indent_do = 3

let g:psc_ide_syntastic_mode = 1
let g:latex_to_unicode_tab = 1
let g:latex_to_unicode_auto = 0
let g:latex_to_unicode_file_types = ["*.purs", "*.hs"]

autocmd FileType purescript inoremap -> →
autocmd FileType purescript inoremap => ⇒
autocmd FileType purescript inoremap <- ←
autocmd FileType purescript inoremap \fe ∀
autocmd FileType purescript inoremap \fa ∀

let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

autocmd FileType purescript nnoremap  <buffer> <silent> <leader>t :call PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>T :call PSCIDEaddTypeAnnotation(matchstr(getline(line(".")), '^\s*\zs\k\+\ze'))<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>s :call PSCIDEapplySuggestion([])<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>a :call PSCIDEaddTypeAnnotation()<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>i :call PSCIDEimportIdentifier(PSCIDEgetKeyword())<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>r :call PSCIDEload()<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>p :call PSCIDEpursuit(PSCIDEgetKeyword())<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>C :call PSCIDEcaseSplit("!")<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>f :call PSCIDEaddClause("")<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> <leader>qa :call PSCIDEaddImportQualifications()<CR>
autocmd FileType purescript nnoremap  <buffer> <silent> ]d :call PSCIDEgoToDefinition("", PSCIDEgetKeyword())<CR>

" Java
let g:JavaComplete_EnableDefaultMappings = 0
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java nnoremap <buffer> <silent> <leader>i <Plug>(JavaComplete-Imports-AddSmart)

tnoremap jk <C-\><C-n>
command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
set inccommand=nosplit

let g:neoformat_enabled_haskell = ['hindent']

"replaced neomake with ale
"let g:neomake_haskell_enabled_makers = ['hlint']
"let g:neomake_open_list = 2

"call neomake#configure#automake('w')

"augroup fmt
"autocmd!
"au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | endtry
"augroup END

nnoremap <silent> { :copen<CR>
nnoremap <silent> } :cclose<CR>
nnoremap <silent> ( :lopen<CR>
nnoremap <silent> ) :lclose<CR>

" [Buffers] Jump to the existing window if possible
"let g:fzf_buffers_jump = 1
"command! -bang -nargs=? -complete=dir Files
  "\ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
"nnoremap <silent> ; :Buffers
"nnoremap <silent> ' :GFiles
"nnoremap <silent> <leader>' :Files
"nnoremap <silent> <leader>/ :Ag

" Use deoplete.
let g:deoplete#enable_at_startup = 1

if !exists('g:psc_ide_server_port')
  let g:psc_ide_server_port = system('echo -n $[${RANDOM}%3000+4000]')
endif

"let g:workspace_autocreate =1
"let g:workspace_session_name = '.session.vim'
""let g:workspace_session_disable_on_args = 1
"let g:workspace_autosave_always = 0

"autocmd FileType purescript inoremap <silent> .. ∘
"autocmd FileType purescript inoremap <silent> :: ∷
autocmd FileType purescript set keywordprg=pursuit

autocmd FileType netrw setl bufhidden=delete

set splitbelow
set splitright
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-c> :tabclose<CR>
nnoremap <silent> <C-f1> :tabprevious<CR>
nnoremap <silent> <C-f2> :tabnext<CR>
nnoremap H gT
nnoremap L gt

call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
			\ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#option('default', {
  \ 'prompt': '>',
  \ 'short_source_names': v:true
  \ })
call denite#custom#source('_', 'matchers',
  \ [ 'matcher/fuzzy'
  \ , 'matcher/ignore_current_buffer'
  \ ])
call denite#custom#source('_', 'sorters',
  \ [ 'sorter/sublime'
  \ ])
call denite#custom#map(
  \ 'insert',
  \ '<C-j>',
  \ '<denite:move_to_next_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<C-k>',
  \ '<denite:move_to_previous_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<Down>',
  \ '<denite:move_to_next_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<Up>',
  \ '<denite:move_to_previous_line>',
  \ 'noremap'
  \)
call denite#custom#map('insert', '<C-a>', '<Home>')
call denite#custom#map('insert', '<C-e>', '<End>')
nnoremap <silent> ; :Denite buffer<CR>
nnoremap <silent> <leader>' :Denite file/rec buffer<CR>
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command',
  \ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> ' :Denite file/rec/git buffer<CR>
nnoremap <silent> : :Denite command_history<CR>
nnoremap <silent> \ :Denite grep<CR>
nnoremap <silent>  :Denite line<CR>
nnoremap <silent> <leader>r :call denite#custom#source('_', 'matchers',
  \ [ 'matcher/fuzzy', 'matcher/ignore_current_buffer' ])
nnoremap <silent> <leader>R :call denite#custom#source('_', 'matchers',
  \ [ 'matcher/regexp' ])

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

"go setup
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nnoremap <buffer> <silent> <leader>i :GoImport<CR>
autocmd FileType go nnoremap <buffer> <silent> <leader>f :GoDef<CR>
autocmd FileType go nnoremap <buffer> <silent> <leader>D :GoDescribe<CR>
autocmd FileType go nnoremap <buffer> <silent> <leader>F :GoReferrers<CR>
autocmd FileType go nnoremap <buffer> <silent> <leader>I :GoImplement<CR>
autocmd FileType go nnoremap <buffer> <silent> <leader>W :GoWhicherrs<CR>
autocmd FileType go nnoremap <buffer> <silent> <leader>C :GoChannelPeers<CR>
autocmd FileType go nnoremap <buffer> <silent> <leader>R :GoRename
autocmd FileType go nnoremap <buffer> <silent> <leader>P :GoPlay<CR>
autocmd FileType go nnoremap <buffer> <silent> K :GoDoc<CR>
autocmd FileType go nnoremap <leader>gi <Plug>(go-info)

" Move visual selection
vnoremap <silent> J :m '>+1gv=gv<CR>
vnoremap <silent> K :m '<-2gv=gv<CR>

" For Devicons
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enabl = 0
let g:WebDevIconsUnicodeDecorateFolderNodes = 0
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" loading the plugin
"let g:webdevicons_enable = 1
"" vim-airline with Devicons
"let g:airline_powerline_fonts = 1
"" adding to vim-airline's tabline
"let g:webdevicons_enable_airline_tabline = 1
"" adding to vim-airline's statusline
"let g:webdevicons_enable_airline_statusline = 1
"" use double-width(1) or single-width(0) glyphs
"" only manipulates padding, has no effect on terminal or set(guifont) font
"let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
"" Adding the custom source to denite
"let g:webdevicons_enable_denite = 1
"" change the default character when no match found
"let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'
"" enable folder/directory glyph flag (disabled by default with 0)
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['nix'] = ''
"let g:webdevicons_enable_nerdtree = 1
"let g:DevIconsEnableFoldersOpenClose = 1
""Specific
"let g:WebDevIconsOS = 'Darwin'
" ENd of For Devicons

"let g:slime_target = "tmux"
"let g:slime_paste_file = tempname()
"let g:slime_no_mappings = 1
"let g:slime_dont_ask_default = 1

"let g:slime_default_config = {"socket_name": "/tmp/default", "target_pane": "{down-of}"}
"vnoremap <silent> <Leader>e :SlimeSend<CR>
"nnoremap <silent> <Leader>e :SlimeSendCurrentLine<CR>

let g:LanguageClient_serverCommands = {
\ 'clojure': ['sh', '-c', 'clojure-lsp'],
\ }
"let g:LanguageClient_serverCommands = { 'haskell': ['hie-wrapper'] }
"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
"map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
"map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
"map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
"map <Leader>lb :call LanguageClient#textDocument_references()<CR>
"map <leader>la :call LanguageClient#textDocument_codeAction()<CR>
"map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
"hi link ALEError Error
"hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
"hi link ALEWarning Warning
"hi link ALEInfo SpellCap
"let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']

call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
call deoplete#custom#var('buffer', 'require_same_filetype', v:false)    " otherbuffer complete
call deoplete#custom#source('LanguageClient','mark', 'ℰ')
call deoplete#custom#source('omni',          'mark', '⌾')
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
"call deoplete#custom#source('ale',          'mark', '⌁')
"call deoplete#custom#source('flow',          'mark', '⌁')
"call deoplete#custom#source('ternjs',        'mark', '⌁')
"call deoplete#custom#source('go',            'mark', '⌁')
"call deoplete#custom#source('jedi',          'mark', '⌁')
"call deoplete#custom#source('vim',           'mark', '⌁')
"call deoplete#custom#source('ultisnips',     'mark', '⌘')
"call deoplete#custom#source('around',        'mark', '↻')
"call deoplete#custom#source('buffer',        'mark', 'ℬ')
"call deoplete#custom#source('tmux-complete', 'mark', '⊶')
"call deoplete#custom#source('syntax',        'mark', '♯')
"call deoplete#custom#source('member',        'mark', '.')
"call deoplete#custom#source('ale', 'rank', 500)    " change the ale ranking

let g:hdevtools_options = '-g-isrc -g-Wall --nostack'
"let g:ale_haskell_hdevtools_options = '-g-isrc -g-Wall --nostack'
let g:hdevtools_stack = 0

"let g:ale_completion_enabled = 1

autocmd FileType haskell nnoremap <silent> <leader>i :HoogleInfo<CR>
autocmd FileType haskell nnoremap <silent> <leader>I :HoogleClose<CR>
autocmd FileType haskell nnoremap <silent> <leader><leader> :Unite haskellimport<CR>i

" Clojure Bindings
"let g:slimv_swank_clojure = '! xterm -e lein swank &'
"let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"sbcl --load ~/.vim/slime/start-swank.lisp\""'
" vim surrond
nmap <leader>sb yssb
"nmap <Leader>F <Plug>FireplacePrint<Plug>(sexp_outer_top_list)``
"nmap <Leader>f <Plug>FireplacePrint<Plug>(sexp_outer_list)``
"nmap <Leader>e <Plug>FireplacePrint<Plug>(sexp_inner_element)``
nmap <Leader>d [<C-D>
nmap <Leader>E :%Eval<CR>
nmap <Leader>R cqp(require 'clojure.tools.namespace.repl) (clojure.tools.namespace.repl/refresh)<CR>
nmap <Leader>w( ysie)
nmap <Leader>w[ ysie]
nmap <Leader>w{ ysie}
nmap <Leader>w" ysie"
vmap <Leader>w( S)
vmap <Leader>w[ S]
vmap <Leader>w{ S}
vmap <Leader>w" S"

nmap <S-Right> <Plug>(sexp_capture_next_element)<Plug>(sexp_indent)
nmap <S-Left> <Plug>(sexp_emit_tail_element)<Plug>(sexp_indent)
imap <S-Right> <C-O><Plug>(sexp_capture_next_element)<C-O><Plug>(sexp_indent)
imap <S-Left> <C-O><Plug>(sexp_emit_tail_element)<C-O><Plug>(sexp_indent)

let g:sexp_mappings = {
      \ 'sexp_outer_list':                'af',
      \ 'sexp_inner_list':                'if',
      \ 'sexp_outer_top_list':            'aF',
      \ 'sexp_inner_top_list':            'iF',
      \ 'sexp_outer_string':              'as',
      \ 'sexp_inner_string':              'is',
      \ 'sexp_outer_element':             'ae',
      \ 'sexp_inner_element':             'ie',
      \ 'sexp_move_to_prev_bracket':      '(',
      \ 'sexp_move_to_next_bracket':      ')',
      \ 'sexp_indent_top':                '=-',
      \ 'sexp_round_head_wrap_element':   '<Leader>W',
      \ 'sexp_swap_element_backward':     '<Leader>T',
      \ 'sexp_swap_element_forward':      '<Leader>t',
      \ 'sexp_raise_element':             '<Leader>''',
      \ 'sexp_emit_head_element':         '<Leader>{',
      \ 'sexp_emit_tail_element':         '<Leader>}',
      \ 'sexp_capture_prev_element':      '<Leader>[',
      \ 'sexp_capture_next_element':      '<Leader>]',
      \ 'sexp_flow_to_next_open_bracket': '<M-f>',
      \ 'sexp_flow_to_prev_open_bracket': '<M-b>',
      \ }
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
