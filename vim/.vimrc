set nocompatible              " be iMproved, required
set encoding=utf-8            " Make sure we are always using utf-8
filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle For Managing Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged')
"{{ The Basics }}
     Plugin 'gmarik/Vundle.vim'                           " Vundle
     Plugin 'iamcco/markdown-preview.nvim'                " Markdown Preview
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
    Plugin 'tpope/vim-surround'                          " Vim surrouand
    Plugin 'tpope/vim-sensible'                          " Sensible defaults
    Plugin 'tpope/vim-capslock'                          " Software caps lock

"{{ Syntax Highlighting and Colors }}
    Plugin 'PotatoesMaster/i3-vim-syntax'                " i3 config highlighting
    Plugin 'kovetskiy/sxhkd-vim'                         " sxhkd highlighting
    Plugin 'vim-python/python-syntax'                    " Python highlighting
    Plugin 'ap/vim-css-color'                            " Color previews for CSS
    Plugin 'Yggdroot/indentLine'                         " Show tab indents

"{{ Junegunn Choi Plugins }}
    Plugin 'junegunn/goyo.vim'                           " Distraction-free viewing
    Plugin 'junegunn/limelight.vim'                      " Hyperfocus on a range
    Plugin 'junegunn/vim-emoji'                          " Vim needs emojis!

" {{ Training }}
    Plugin 'wikitopian/hardmode'                         " Hard mode

call vundle#end()
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=**                    " Searches current directory recursively.
set wildmenu                    " Display all matches when tab complete.
set incsearch                   " Incremental search
set hidden                      " Needed to keep multiple buffers open
set nobackup                    " No auto backups
set noswapfile                  " No swap
set t_Co=256                    " Set if term supports 256 colors.
set number relativenumber       " Display line numbers
syntax enable                   " Enable syntax highliting
let g:rehash256 = 1
set number                      " Turn on line numbers
set autowrite                   " Turn on autowrite 
colorscheme Tomorrow-Night      " Set theme

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

" remap some commands
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
