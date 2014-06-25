#!/bin/bash

SESSION=OSK

tmux -2 new-session -d -s $SESSION

# Set up a window for running Erlang
tmux new-window -t $SESSION:1 -n 'OSK'
tmux select-pane -t 0
tmux send-keys "cd /host/src/osk" C-m
tmux send-keys ". env.sh" C-m
tmux send-keys "rm -rf deps && make" C-m
tmux send-keys "cd .." C-m
tmux send-keys "nodemon --watch osk/apps -e erl --exec ./osk.sh" C-m

# Set up a new window for running nodejs
# Setup a MySQL window
tmux new-window -t $SESSION:2 -n 'node'
tmux send-keys "cd /host/src/osk/apps/osk/priv/www" C-m
tmux send-keys "make watch" C-m

# Set default window
tmux select-window -t $SESSION:2

# Attach to session
tmux -2 attach-session -t $SESSION
