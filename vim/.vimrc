set nocompatible              " be iMproved, required
set encoding=utf-8 nobomb     " Make sure we are always using utf-8
set background=dark
" let g:solarized_termcolors=256
filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged')
"{{ The Basics }}
     Plugin 'gmarik/Vundle.vim'                           " Vundle
     Plugin 'JamshedVesuna/vim-markdown-preview'          " Markdown Preview
     Plugin 'itchyny/lightline.vim'                       " Lightline statusbar
     Plugin 'frazrepo/vim-rainbow'                        " Rainbow brackets
     Plugin 'editorconfig/editorconfig-vim'               " Editor config

"{{ File management }}
    Plugin 'scrooloose/nerdtree'                         " Nerdtree
    Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'     " Highlighting Nerdtree
    Plugin 'ryanoasis/vim-devicons'                      " Icons for Nerdtree
    Plugin 'junegunn/fzf.vim'                            " Fuzzy command finder

"{{ Productivity }}
    Plugin 'vimwiki/vimwiki'                             " VimWiki
    Plugin 'jreybert/vimagit'                            " Magit-like plugin for vim
    Plugin 'mg979/vim-visual-multi'                      " Visual Block
    Plugin 'ycm-core/YouCompleteMe'                      " Auto completion
    Plugin 'dense-analysis/ale'                          " Auto linter
    Plugin 'airblade/vim-gitgutter'                      " Show git diff
    Plugin 'tpope/vim-fugitive'                          " Git fugative
    Plugin 'zivyangll/git-blame.vim'                     " Git Blame
    Plugin 'tpope/vim-surround'                          " Vim surrouand
    Plugin 'tpope/vim-sensible'                          " Sensible defaults
    Plugin 'tpope/vim-capslock'                          " Software caps lock
    Plugin 'python-mode/python-mode'                     " Python mode
    Plugin 'bkad/CamelCaseMotion'                        " Camel Case Motion
    Plugin 'ap/vim-buftabline'                           " Vim Buffline
    Plugin 'tpope/vim-commentary'                        " Commentary
    Plugin 'tpope/vim-jdaddy'                            " JSON Daddy
    Plugin 'tpope/vim-speeddating'                       " Adjust dates

"{{ Syntax Highlighting and Colors }}
    Plugin 'Vimjas/vim-python-pep8-indent'               " Python indent
    Plugin 'PotatoesMaster/i3-vim-syntax'                " i3 config highlighting
    Plugin 'kovetskiy/sxhkd-vim'                         " sxhkd highlighting
    Plugin 'vim-python/python-syntax'                    " Python highlighting
    Plugin 'ap/vim-css-color'                            " Color previews for CSS
    Plugin 'Yggdroot/indentLine'                         " Show tab indents
    Plugin 'Chiel92/vim-autoformat'                      " Autoformat files
    Plugin 'neoclide/coc'                                " Concoure of Completeion

"{{ Junegunn Choi Plugins }}
    Plugin 'junegunn/goyo.vim'                           " Distraction-free viewing
    Plugin 'junegunn/limelight.vim'                      " Hyperfocus on a range
    Plugin 'junegunn/vim-emoji'                          " Vim needs emojis!

" {{ Training }}
    Plugin 'wikitopian/hardmode'                         " Hard mode

" {{ Theme }}
    Plugin 'arcticicestudio/nord-vim'                    " Nord
    Plugin 'mhinz/vim-startify'                          " Start Screen


call vundle#end()
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap ;; <Esc>
set iskeyword-=_                " Use _ for motions
" Use Grip for markdown preview
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

let vim_markdown_preview_github=1
set cursorline                  " Sets highliting the cursor line
set path+=**                    " Searches current directory recursively.
set wildmenu                    " Display all matches when tab complete.
set incsearch                   " Incremental search
set hidden                      " Needed to keep multiple buffers open
set t_Co=256                    " Set if term supports 256 colors.
set number relativenumber       " Display line numbers
syntax enable                   " Enable syntax highliting
let g:rehash256 = 1
set number                      " Turn on line numbers
set autowrite                   " Turn on autowrite
colorscheme nord                " Set theme
set expandtab                   " Make tabs into spaces (set by tabstop)
set backspace=indent,eol,start  " Allow backspace in insert mode
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif
" Skip terminal buffers
augroup termIgnore
    autocmd!
    autocmd TerminalOpen * set nobuflisted
augroup END

" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``
set colorcolumn=80,120          " Adds guide lines at 80 and 120 characters
" Maps Ctrl+i to insert one character
nnoremap <C-i> i_<Esc>r
set tags=tags

" Shift Enter to create new line then exit
nmap <S-Enter> O<Esc>
" Shift space to create space then exit insert
nmap <S-Space> i<Space><Esc>
let g:python3_host_prog="/usr/local/bin/python"
let NERDTreeRespectWildIgnore=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""  = > Wildignore settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*/node_modules/*
set wildignore+=_site
set wildignore+=*/__pycache__/
set wildignore+=*/venv/*
set wildignore+=*/target/*
set wildignore+=*/.vim$
set wildignore+=\~$
set wildignore+=*/.log
set wildignore+=*/.aux
set wildignore+=*/.cls
set wildignore+=*/.aux
set wildignore+=*/.bbl
set wildignore+=*/.blg
set wildignore+=*/.fls
set wildignore+=*/.fdb*/
set wildignore+=*/.toc
set wildignore+=*/.out
set wildignore+=*/.glo
set wildignore+=*/.log
set wildignore+=*/.ist
set wildignore+=*/.fdb_latexmk
set wildignore+=*.git/
set wildignore+=*.egg-info/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The lightline.vim theme
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

" Always show statusline
set laststatus=2

" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode
" Git Blame in vim
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Be smart using tabs ;)
set shiftwidth=4                " One tab == four spaces.
set tabstop=4                   " One tab == four spaces.
set lcs=space:·                 " Show spaces
set lcs+=tab:\|\                " Show tab
set list!                       " Force showing whitespaces

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Instant-Markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:instant_markdown_autostart = 1         " Turns on auto preview
let g:instant_markdown_browser = "surf"      " Uses surf for preview
" Previews .md file
map <Leader>md :InstantMarkdownPreview<CR>
" Kills the preview
map <Leader>ms :InstantMarkdownStop<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=38
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=35
let NERDTreeQuitOnOpen=1
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open nerdtree window on opening Vim
autocmd VimEnter * NERDTree
" Refresh the current folder if any changes
autocmd BufEnter NERD_tree_* | execute 'normal R'
au CursorHold * if exists("t:NerdTreeBufName") | call <SNR>15_refreshRoot() | endif

"Close nerd tree when its the only buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Reload the window if directory is changed
augroup DIRCHANGE
    au!
    autocmd DirChanged global :NERDTreeCWD
augroup END

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" remap some commands
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
            \ 'python': ['flake8'],
            \ 'javascript': ['eslint'],
            \ 'go': ['gobuild', 'gofmt'],
            \ 'rust': ['rls']
            \}
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['autopep8'],
            \ 'javascript': ['eslint'],
            \ 'go': ['gofmt', 'goimports'],
            \ 'rust': ['rustfmt']
            \}
let g:ale_fix_on_save = 1
let g:ale_virtualenv_dir_names = ["venv"]
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Sweet Sweet FuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>
