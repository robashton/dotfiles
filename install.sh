sudo sh -c 'echo "deb http://archive.canonical.com/ubuntu trusty partner" > /etc/apt/sources.list.d/canonical_partner.list'
sudo dpkg --add-architecture i386

wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install suckless-tools
sudo apt-get install xmonad gnome-panel
sudo apt-get install git vim-gnome
sudo apt-get install exuberant-ctags
sudo apt-get install docker.io

sudo apt-get install acpi

sudo apt-get install skype
