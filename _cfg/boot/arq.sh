#!/bin/bash

# Update our codes
cd $HOME/environments/id3as/src/arqiva-encoder
git pull --rebase

# Open a split for background
gnome-terminal --working-directory=$HOME/environments/id3as --command "bash arqiva.sh /host/assets/arqiva.sh"

# Make sure we own our src
super chown -R robashton $HOME/environments/id3as/src/arqiva-encoder/
super chgrp -R robashton $HOME/environments/id3as/src/arqiva-encoder/

# Open up vim
gnome-terminal --working-directory=$HOME/environments/id3as/src/arqiva-encoder --command "vim"

# And open up a working directory
gnome-terminal --working-directory=$HOME/environments/id3as/src/arqiva-encoder --command "bash -l"

ARQIP=$(super docker inspect id3as | grep IPAddress | awk '{print $2}' | tr -d '",\n')

xdg-open "http://$ARQIP:8080"
