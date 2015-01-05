#!/bin/bash

COMMAND=$1
GSI=$HOME/environments/native/src/gsi
SESSION=GSI


setup_windows() {
  # Update our codes
  pushd $GSI
  git pull --rebase

  # Open a split for background
  gnome-terminal --working-directory=$HOME --command "./run gsi tmux"

  # Open up our working terminal, and vim
  gnome-terminal --working-directory=$GSI --command "vim"
  popd
}

setup_tmux() {

  tmux -2 new-session -d -s $SESSION

  # A window for running stuff
  tmux new-window -t $SESSION:1 -n 'GSI'
  tmux split-window -v

  # A pane for running node
  tmux select-pane -t 0
  tmux send-keys "cd $GSI" C-m
  tmux send-keys "./run.sh" C-m

  # Panes for doing other things
  # This would be running mongo, etc if I was containerising
  tmux select-pane -t 1
  tmux split-window -h
  tmux send-keys "mongod --dbpath /home/robashton/_data" C-m

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
