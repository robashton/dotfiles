#!/bin/bash

# Open a split for background
gnome-terminal --working-directory=$HOME --command "VBoxHeadless -s id3as"

# SSH into that machine
gnome-terminal --working-directory=$HOME --command "ssh id3as@192.168.56.101"
