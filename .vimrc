set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set relativenumber

aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END


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

" Stolen off Artem
" map <leader>t :call RunTestFile()<cr>
" map <leader>T :call RunNearestTest()<cr>
" 
" function! RunTestFile(...)
"   if a:0
"     let command_suffix = a:1
"   else
"     let command_suffix = ""
"   endif
" 
"   " Run the tests for the previously-marked file.
"   let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
"   if in_test_file
"     call SetTestFile()
"   elseif !exists("t:grb_test_file")
"     return
"   end
"   call RunTests(t:grb_test_file . command_suffix)
" endfunction
" 
" function! RunNearestTest()
"   let spec_line_number = line('.')
"   call RunTestFile(":" . spec_line_number)
" endfunction
" 
" function! SetTestFile()
"   " Set the spec file that tests will be run for.
"   let t:grb_test_file=@%
" endfunction
" 
" function! RunTests(filename)
"   :wa
"   if match(a:filename, '\.feature') != -1
"     let l:command = "zeus cucumber " . a:filename
"   else
"     let l:command = "zeus rspec -c " . a:filename
"   end
"   call system("tmux select-window -t " . g:run_tests_in_window)
"   call system('tmux set-buffer "' . l:command . "\n\"")
"   call system('tmux paste-buffer -d -t ' . g:run_tests_in_window)
" endfunction
" 
let g:run_tests_in_window = 1

"Gotta do it this way or the theme won't get loaded"
function! SetTheme()
  colorscheme Tomorrow-Night-Bright
  highlight NonText ctermfg=black
  highlight VertSplit cterm=none gui=none
  highlight clear SignColumn
  highlight CursorLine cterm=none ctermbg=darkgrey
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
