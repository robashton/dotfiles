set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set relativenumber
set mouse=

let g:ghc = 'stackghc'
let g:ghc_pkg = 'stackghcpkg'
let g:shim_ghciInterp = 'stack ghci'
let g:haddock_browser = 'google-chrome'
"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"Disable syntastic cos vimerl does this better
let g:syntastic_erlang_checkers = []
let g:syntastic_javascript_checkers = ['eslint']

" Allow project specific defaults (mostly override the above)
if filereadable(".vim.custom")
    so .vim.custom
endif

aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Gnome terminal supports 256 colours
" So enable it if we want
if $COLORTERM == 'gnome-terminal'
  set t_Co=256 " For tomorrow-night
  "set t_Co=16 " For solarized
endif



"set completeopt=longest,menuone
syntax on
filetype plugin indent on
let vimclojure#HighlightBuiltins =1
let vimclojure#ParenRainbow =1


set lazyredraw


let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*,*.d,*.beam


nnoremap bn :bn<cr>
nnoremap bl :bp<cr>

autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
"autocmd CursorHold * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))

autocmd BufRead *.dtl set ft=htmldjango
autocmd BufWritePost *.hs :GhciFile
autocmd BufWritePost *.elm :ElmFormat


nnoremap gd :OmniSharpGotoDefinition<cr>
autocmd CursorHold *.cs call OmniSharp#TypeLookup()
set updatetime=500
set cmdheight=1


"
"nnoremap <space> :OmniSharpGetCodeActions<cr>
nnoremap <leader>tp :OmniSharpAddToProject<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <space> :GhcModType<cr>

" Load all the plug-ins
call pathogen#infect()

" It's dirty, but this is an easy way to resize my windows
nnoremap <C-left> :vertical resize -10<cr>
nnoremap <C-down> :resize +10<cr>
nnoremap <C-up> :resize -10<cr>
nnoremap <C-right> :vertical resize +10<cr>

" I like a solid line
set fcs+=vert:│

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Shove all  the temporary files in one place
set swapfile
set dir=~/tmp
set backupdir=~/tmp


" Overwrite the ack default to use silversearcher
let g:ackprg="ack -H --nocolor --nogroup --column"
if executable("ag")
  let g:ackprg="ag --nogroup --nocolor --column"
  set grepprg=ag\ --noheading\ --nogroup\ --nocolor
endif

" Search for current symbol
noremap <Leader>a :Ack <cword><cr> --ignore-dir input
map <C-n> :NERDTreeToggle<CR>

"Gotta do it this way or the theme won't get loaded"
function! SetDarkTheme()
  colorscheme Tomorrow-Night-Bright
  highlight NonText ctermfg=black
  highlight SpellBad ctermfg=black
  highlight VertSplit cterm=none gui=none
  highlight clear SignColumn
  highlight CursorLine cterm=none ctermbg=235
  highlight LineNr ctermfg=darkgrey
  highlight StatusLine ctermfg=white ctermbg=darkblue
  highlight StatusLineNC ctermfg=white ctermbg=blue
  highlight Normal ctermbg=none
endfunction

" Having a change of scenery
function! SetLightTheme()
  colorscheme default
  highlight NonText ctermfg=black
  highlight VertSplit cterm=none gui=none
  highlight clear SignColumn
  highlight CursorLine cterm=none ctermbg=lightgrey
  highlight LineNr ctermfg=darkgrey
  highlight StatusLine ctermfg=darkblue ctermbg=white
  highlight StatusLineNC ctermfg=darkgrey ctermbg=blue
endfunction

function! SetSolarized()
  set background=dark
  colorscheme solarized
endfunction

" This is a bit cheeky, but it's pretty useful when in Thailand
function! Daytime()
  colorscheme default
  set guifont=Ubuntu\ Mono\ 14
endfunction

augroup theming
  autocmd!
  autocmd VimEnter * call SetDarkTheme()
augroup END


" Hide all the GUI if we're in gvim (which is nearly always)
set guioptions+=LlRrb
set guioptions-=LlRrb
set guioptions-=M
set guioptions-=m
set guioptions-=T
set guiheadroom=0
set guifont=Ubuntu\ Mono\ 10

" Search for the tags from home onwards (so I can work in child dirs)
set tags+=$HOME

" Disable the mouse as much as we can
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

autocmd BufWritePre *.erl :%s/\s\+$//e " Get rid of trailing whitespace in erlang only

if !empty(glob("erl.mk"))
  :set path+=apps/**
  :set path+=deps/**
endif

if !empty(glob(".git"))
  function! GitLsFilesModified(A,L,P)
    let pattern = a:A
    if len(pattern) > 0
      return split(system("git ls-files --modified \| grep " . pattern), "\n")
    else
      return split(system("git ls-files --modified"), "\n")
    endif
  endfunction
  command! -complete=customlist,GitLsFilesModified -nargs=1 G :edit <args>
endif

