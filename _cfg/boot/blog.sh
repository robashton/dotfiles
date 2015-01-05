#!/bin/bash

COMMAND=$1
BLOG=$HOME/environments/native/src/blog
SESSION=BLOG


setup_windows() {
  # Open a split for background
  gnome-terminal --working-directory=$HOME --command "./run blog tmux"

  # Open up our working terminal, and vim
  gnome-terminal --working-directory=$BLOG --command "vim input/pages/"
}

setup_tmux() {

  tmux -2 new-session -d -s $SESSION

  # A window for running stuff
  tmux new-window -t $SESSION:1 -n 'BUILD'
  tmux split-window -v

  # Run the server
  tmux select-pane -t 0
  tmux send-keys "cd $BLOG" C-m
  tmux send-keys "node server" C-m

  tmux select-pane -t 1
  tmux send-keys "cd $BLOG" C-m
  tmux send-keys "node build" C-m

  # Set default window
  tmux select-window -t $SESSION:1

  # Attach to session
  tmux -2 attach-session -t $SESSION
}

case $COMMAND in
  tmux)
    setup_tmux
    ;;
  *)
    setup_windows
    exec bash $0 tmux
    ;;
esac
