set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set relativenumber



colorscheme desert
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
highlight clear SignColumn

highlight StatusLineNC cterm=none ctermbg=white gui=none ctermfg=black
highlight StatusLine ctermbg=red cterm=none gui=none ctermfg=black
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
highlight NonText ctermfg=black

hi TabLineFill ctermfg=grey ctermbg=white
hi TabLine ctermfg=black ctermbg=white
hi TabLineSel ctermfg=black ctermbg=red

hi CursorLine cterm=none ctermbg=darkgrey

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
  au WinLeave * setlocal nocursorline
  au WinLeave * setlocal nocursorcolumn
augroup END

set swapfile
set dir=~/tmp
set backupdir=~/tmp

highlight LineNr ctermfg=darkgrey


au BufRead,BufNewFile *.kt setfiletype kotlin

let g:ackprg="ack -H --nocolor --nogroup --column"
if executable("ag")
  let g:ackprg="ag --nogroup --nocolor --column"
  set grepprg=ag\ --noheading\ --nogroup\ --nocolor
endif


" Stolen off Artem
map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTests(filename)
  :wa
  if match(a:filename, '\.feature') != -1
    let l:command = "zeus cucumber " . a:filename
  else
    let l:command = "zeus rspec -c " . a:filename
  end
  call system("tmux select-window -t " . g:run_tests_in_window)
  call system('tmux set-buffer "' . l:command . "\n\"")
  call system('tmux paste-buffer -d -t ' . g:run_tests_in_window)
endfunction

let g:run_tests_in_window = 1
