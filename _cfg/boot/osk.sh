#!/bin/bash

# Update our codes
cd $HOME/environments/id3as/src/osk
git pull --rebase

# Open a split for background
gnome-terminal --working-directory=$HOME/environments/id3as --command "bash run.sh /host/assets/osk.sh"

# Make sure we own our src
super chown -R robashton $HOME/environments/id3as/src/osk/
super chgrp -R robashton $HOME/environments/id3as/src/osk/

# Open up our working terminal, and vim
gnome-terminal --working-directory=$HOME/environments/id3as/src/osk --command "vim"

# Leave this terminal open for luls
echo "Go to work brave soldier"
