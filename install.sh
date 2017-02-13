#!/bin/bash

if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root"
  exit 1
fi

set +e

function package_exists {
   return $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed")
};

function config_exists {
  local file=$1
  local line=$2
  return $(grep -Fxq "$line" $file)
}

function apt_install {
  local package=$1
  package_exists $package
  if [ $? -eq 1 ]; then
    echo "Skipping $@"
  else
    echo
    echo Installing $@
    echo
    DEBIAN_FRONTEND=noninteractive apt-get -qy install $@
  fi
};

function ensure_sources {
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
  apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-yakkety main'
  apt-get update
  apt-get upgrade
};

function install_erlang {
  package_exists "erlang"
  if [ $? -eq 0 ]; then
    echo "Installing Erlang"
    wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
    dpkg -i erlang-solutions_1.0_all.deb
  else
    echo "Skipping Erlang"
  fi;
}

function install_packages {
    apt_install xmonad
    apt_install gnome-panel
    apt_install gnome-shell
    install_erlang
    apt_install tig
    apt_install suckless-tools
    apt_install ghc
    apt_install ghc-mod
    apt_install vim-gnome
    apt_install exuberant-ctags
    apt_install acpi
    apt_install skype
    apt_install nodejs
    apt_install build-essential
    apt_install silversearcher-ag
    apt_install tmux
    apt_install kdiff3
    apt_install openssh-server
    apt_install htop
    apt_install gawk
    apt_install docker-engine
}

function setup_xmonad {
  echo "Setting up xmonad"
  xmonad --recompile
}

function setup_git {
  git config --global user.name "Rob Ashton"
  git config --global user.email "robashton@codeofrob.com"
  git config --global push.default simple
}

function setup_user {
  usermod -a -G docker robashton
}

function setup_symlinks {
  ln -fs /usr/bin/nodejs /usr/bin/node
}

function setup_vim {
  ./_cfg/setup_vim.sh
}

ensure_sources
install_packages
setup_super
setup_vim
setup_xmonad
setup_user
