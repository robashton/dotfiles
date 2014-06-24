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
  sh -c 'echo "deb http://archive.canonical.com/ubuntu trusty partner" > /etc/apt/sources.list.d/canonical_partner.list'
  dpkg --add-architecture i386
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
    install_erlang
    apt_install suckless-tools
    apt_install git
    apt_install vim-gnome
    apt_install exuberant-ctags
    apt_install acpi
    apt_install docker.io
    apt_install skype
    apt_install super
}

function setup_super {
  local config="docker.io /usr/bin/docker.io robashton"
  local file="/etc/super.tab"
  config_exists $file $config
  if [ $? -eq 0 ]; then
    echo "Adding docker to super"
    echo $config >> $file
  else
    echo "Super already configured"
  fi;
}

ensure_sources
install_packages
setup_super
