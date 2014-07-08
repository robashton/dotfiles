#!/bin/bash

SESSION=OSK

tmux -2 new-session -d -s $SESSION

# A window for running stuff
tmux new-window -t $SESSION:1 -n 'OSK'
tmux split-window -v

# A pane for running Erlang
tmux select-pane -t 0
tmux send-keys "cd /host/src/osk" C-m
tmux send-keys ". env.sh" C-m
tmux send-keys "cd deps/id3as_media && git pull && cd ../.." C-m
tmux send-keys "cd deps/id3as_common && git pull && cd ../.." C-m
tmux send-keys "make" C-m
tmux send-keys "cd ../" C-m
tmux send-keys "nodemon --watch osk/apps -e erl --exec ./osk.sh" C-m

tmux select-pane -t 1
tmux split-window -h

# Watch js
tmux select-pane -t 1
tmux send-keys "cd /host/src/osk/apps/osk/priv/www" C-m
tmux send-keys "make watch-js" C-m

# Watch css
tmux select-pane -t 2
tmux send-keys "cd /host/src/osk/apps/osk/priv/www" C-m
tmux send-keys "make watch-css" C-m

# Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION
