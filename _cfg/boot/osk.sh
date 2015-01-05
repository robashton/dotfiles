#!/bin/bash

# Update our codes
cd $HOME/environments/id3as/src/osk
git pull --rebase || { echo "Failed to git ull, carrying on"; }

# Open a split for occy
gnome-terminal --working-directory=$HOME/environments/id3as --command "bash occy.sh"

# Wait for it to start
echo "Waiting for occy to start"
sleep 20
echo "Waited, going for it"

# Open a split for background
gnome-terminal --working-directory=$HOME/environments/id3as --command "bash osk.sh /host/assets/osk.sh"

# Make sure we own our src
super chown -R robashton $HOME/environments/id3as/src/osk/
super chgrp -R robashton $HOME/environments/id3as/src/osk/

# Open up our working terminal, and vim
gnome-terminal --working-directory=$HOME/environments/id3as/src/osk --command "vim"

# Leave this terminal open for luls
echo "Go to work brave soldier"

OCCYIP=$(super docker inspect occy | grep IPAddress | awk '{print $2}' | tr -d '",\n')
OSKIP=$(super docker inspect id3as | grep IPAddress | awk '{print $2}' | tr -d '",\n')

xdg-open "http://$OSKIP:8081"
