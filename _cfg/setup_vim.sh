#!/bin/bash

function install_plugin {
  local source=$1
  local output=$2
  local full_path=$HOME"/.vim/bundle/$output"
  if [ ! -d "$full_path" ]; then
    echo "Installing $output from $source"
    git clone $source $full_path
  else
    cd $full_path
    git pull
  fi;
}

install_plugin "https://github.com/kchmck/vim-coffee-script.git" "vim-coffee-script"
install_plugin "https://github.com/digitaltoad/vim-jade.git" "vim-jade"
install_plugin "https://github.com/wavded/vim-stylus.git" "vim-stylus"
install_plugin "https://github.com/scrooloose/syntastic.git" "syntastic"
install_plugin "https://github.com/tpope/vim-sensible.git" "vim-sensible"
install_plugin "https://github.com/tpope/vim-rails.git"	"vim-rails"
install_plugin "https://github.com/mileszs/ack.vim.git"	"ack.vim"
install_plugin "https://github.com/tpope/vim-fugitive.git" "vim-fugitive"
install_plugin "https://github.com/jgdavey/tslime.vim.git" "tslime.vim"
install_plugin "https://github.com/tpope/vim-dispatch.git" "vim-dispatch"
install_plugin "https://github.com/felixge/vim-nodejs-errorformat.git" "vim-nodejs-errorformat"
install_plugin "https://github.com/briancollins/vim-jst.git" "vim-jst"
install_plugin "https://github.com/pangloss/vim-javascript.git" "vim-javascript"
install_plugin "https://github.com/tpope/vim-surround.git" "vim-surround"
install_plugin "https://github.com/guns/vim-clojure-static.git" "vim-clojure-static"
install_plugin "https://github.com/tpope/vim-fireplace.git" "vim-fireplace"
install_plugin "https://github.com/vim-scripts/paredit.vim.git" "paredit.vim.git"
install_plugin "https://github.com/kien/ctrlp.vim.git" "ctrlp.vim"
install_plugin "https://github.com/dgrnbrg/vim-redl.git" "vim-redl"
install_plugin "https://github.com/scrooloose/nerdtree.git" "nerdtree"
install_plugin "https://github.com/altercation/vim-colors-solarized.git" "vim-solarized"
install_plugin "https://github.com/bling/vim-airline.git" "vim-airline"
install_plugin "https://github.com/mxw/vim-jsx.git" "vim-jsx"
install_plugin "https://github.com/edkolev/erlang-motions.vim.git" "erlang-motions.vim"
install_plugin "https://github.com/eagletmt/ghcmod-vim.git" "ghcmod-vim"
install_plugin "https://github.com/eagletmt/neco-ghc.git" "neco-ghc"
install_plugin "https://github.com/neovimhaskell/haskell-vim.git" "haskell-vim"
install_plugin "git@github.com:Shougo/vimproc.vim.git" "vimproc.vim"
install_plugin "git@github.com:ElmCast/elm-vim.git" "elm-vim"

pushd "$HOME/.vim/bundle/vimproc.vim"
make
popd

mkdir -p "$HOME/.vim/plugin"
curl "http://www.vim.org/scripts/download_script.php?src_id=20377" > "$HOME/.vim/plugin/shim.vim"
curl "http://www.vim.org/scripts/download_script.php?src_id=6678" > "$HOME/.vim/syntax/htmldjango.vim"
