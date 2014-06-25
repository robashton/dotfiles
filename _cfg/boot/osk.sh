#!/bin/bash

# Open a split for background
gnome-terminal --working-directory=$HOME/environments/id3as --command "bash run.sh /host/assets/osk.sh"

# Make sure we own our src
super chown -R robashton $HOME/environments/id3as/src/osk/
super chgrp -R robashton $HOME/environments/id3as/src/osk/

# Launch vim in this session
cd $HOME/environments/id3as/src/osk
vim
