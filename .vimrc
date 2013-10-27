set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set relativenumber
set mouse=

aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

syntax on
filetype plugin indent on
let vimclojure#HighlightBuiltins =1      " Highlight Clojure's builtins
let vimclojure#ParenRainbow =1           " Rainbow parentheses'!
call pathogen#infect()
nnoremap <C-left> :vertical resize -10<cr>
nnoremap <C-down> :resize +10<cr>
nnoremap <C-up> :resize -10<cr>
nnoremap <C-right> :vertical resize +10<cr>
set fcs+=vert:│

let javascript_enable_domhtmlcss=1
let g:javascript_conceal=1

"hi TabLineFill ctermfg=grey ctermbg=white
"hi TabLine ctermfg=black ctermbg=white
"hi TabLineSel ctermfg=black ctermbg=red

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

set swapfile
set dir=~/tmp
set backupdir=~/tmp

au BufRead,BufNewFile *.kt setfiletype kotlin

let g:ackprg="ack -H --nocolor --nogroup --column"
if executable("ag")
  let g:ackprg="ag --nogroup --nocolor --column"
  set grepprg=ag\ --noheading\ --nogroup\ --nocolor
endif

noremap <Leader>a :Ack <cword><cr> --ignore-dir input
noremap <Leader>s :w!<cr>
noremap <Leader>m :w!<cr>:! mocha<cr>

let g:run_tests_in_window = 1

"Gotta do it this way or the theme won't get loaded"
function! SetTheme()
  colorscheme Tomorrow-Night-Bright
  highlight NonText ctermfg=black
  highlight VertSplit cterm=none gui=none
  highlight clear SignColumn
  highlight CursorLine cterm=none ctermbg=235
  highlight LineNr ctermfg=darkgrey
  highlight StatusLine ctermfg=white ctermbg=darkblue
  highlight StatusLineNC ctermfg=white ctermbg=blue
endfunction

augroup theming
  autocmd!
  autocmd VimEnter * call SetTheme()
augroup END

set guioptions+=LlRrb
set guioptions-=LlRrb
set guioptions-=M
set guioptions-=m
set guioptions-=T
set guiheadroom=0
set tags=$HOME/

noremap <ScrollWheelUp>      <nop>
noremap <S-ScrollWheelUp>    <nop>
noremap <C-ScrollWheelUp>    <nop>
noremap <ScrollWheelDown>    <nop>
noremap <S-ScrollWheelDown>  <nop>
noremap <C-ScrollWheelDown>  <nop>
noremap <ScrollWheelLeft>    <nop>
noremap <S-ScrollWheelLeft>  <nop>
noremap <C-ScrollWheelLeft>  <nop>
noremap <ScrollWheelRight>   <nop>
noremap <S-ScrollWheelRight> <nop>
noremap <C-ScrollWheelRight> <nop>

