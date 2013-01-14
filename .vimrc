set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
syntax on
filetype plugin indent on
let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1          
call pathogen#infect()
nnoremap <C-left> :vertical resize -10<cr>
nnoremap <C-down> :resize +10<cr>
nnoremap <C-up> :resize -10<cr>
nnoremap <C-right> :vertical resize +10<cr>
highlight VertSplit cterm=none gui=none
set fcs+=vert:│

highlight StatusLineNC cterm=none ctermbg=white gui=none ctermfg=black
highlight StatusLine ctermbg=red cterm=none gui=none ctermfg=black
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
highlight NonText ctermfg=black

hi TabLineFill ctermfg=grey ctermbg=white
hi TabLine ctermfg=black ctermbg=white
hi TabLineSel ctermfg=black ctermbg=red
