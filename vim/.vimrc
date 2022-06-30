
" BASIC SETTINGS ------------------------------------ {{{


" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Use smart tab. This option makes <TAB> and <BS> operate using shiftwidth.
set smarttab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
" set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=100

"Set default foldmethod to indent.
set foldmethod=indent

" Set cino to line up new line with unclosed paren directly after first
" opening paren
set cino+=(0

" Wild Menu settings
set wildmenu
" set wildmode=list:longest
" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

augroup numbertoggle
  autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

augroup openfolds
    autocmd!
    autocmd BufWinEnter * silent! :%foldopen!
augroup end

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

function! IndentIgnoringComments()
 let in_comment = 0
  for i in range(1, line('$'))
    if !in_comment
      " Check if this line starts a comment
      if getline(i) =~# '^\s*/\*\*'
        let in_comment = 1
      else
        " Indent line 'i'
        execute i . "normal =="
      endif
    else
      " Check if this line ends the comment
      if getline(i) =~# '\*\/\s*$'
        let in_comment = 0
      endif
    endif
  endfor
endfunction

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

" Disable vim-polyglot's autoindent as it's causing trouble
let g:polyglot_disabled = ['autoindent']

call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align'

" Plug 'preservim/nerdtree'

call plug#end()

" }}}

" PLUGIN SETTINGS -------------------------------------------------------- {{{

" Add a custom rule for vim-easy-align
let g:easy_align_delimiters = {
\   '\': {
\       'pattern': '\\',
\       'delimiter_align': 'l',
\       'ignore_groups': ['!Comment'],
\       'left_margin': 4,
\       'right_margin': 4 },
\ }

" }}}

" COLOR OPTIONS ---------------------------------------------------------------- {{{

set background=dark
colorscheme codedark

" }}}

" MAPPINGS  ---------------------------------------------------------------- {{{

let mapleader = " "

" Shortcut changing windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Shortcut to move lines up and down
nnoremap <leader>sj :m +1<CR>==
nnoremap <leader>sk :m -2<CR>==

" CtrlP Mappings
let g:ctrlp_map = '<^p>'
let g:ctrlp_cmd = 'CtrlP'

" Easy Align Mappings

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Search for text in visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Add a mapping for checking the hightlight group of object under cursor
nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
"set statusline=

" Status line left side.
"set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
"set statusline+=%=

" Status line right side.
"set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
"set laststatus=2

" }}}
