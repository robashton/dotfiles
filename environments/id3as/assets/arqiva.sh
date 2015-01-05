#!/bin/bash

SESSION=ARQIVA

tmux -2 new-session -d -s $SESSION

# A window for running stuff
tmux new-window -t $SESSION:1 -n 'Manager'
tmux split-window -v

# A pane for running the manager
tmux select-pane -t 0
tmux send-keys "cd /host/src/arqiva-encoder" C-m
tmux send-keys ". env.sh" C-m
#tmux send-keys "./our_deps.sh" C-m
tmux send-keys "make" C-m
tmux send-keys "./run.sh -m robashton manager" C-m

tmux select-pane -t 1
tmux split-window -h

# Watch js
tmux select-pane -t 1
tmux send-keys "cd /host/src/arqiva-encoder/apps/manager/priv/www" C-m
tmux send-keys "make watch-js" C-m

# Watch css
tmux select-pane -t 2
tmux send-keys "cd /host/src/arqiva-encoder/apps/manager/priv/www" C-m
tmux send-keys "make watch-css" C-m

# And a new window for running our nodes
tmux new-window -t $SESSION:2 -n 'Nodes'
tmux split-window -v

tmux select-pane -t 0
tmux send-keys "cd /host/src/arqiva-encoder" C-m
tmux send-keys "sleep 20 && ./run.sh -m robashton http" C-m

tmux select-pane -t 1
tmux send-keys "cd /host/src/arqiva-encoder" C-m
tmux send-keys "sleep 20 && ./run.sh -m robashton bootstrap" C-m

# Fake encoders (but don't run them)
tmux new-window -t $SESSION:3 -n 'FakeEncoders'
tmux split-window -h
tmux select-pane -t 0
tmux send-keys "cd /host/src/arqiva-encoder" C-m
tmux send-keys ". env.sh" C-m
tmux send-keys "/host/assets/fake-encoder-5555"
tmux select-pane -t 1
tmux send-keys "cd /host/src/arqiva-encoder" C-m
tmux send-keys ". env.sh" C-m
tmux send-keys "/host/assets/fake-encoder-4444"

# Run Mongo
tmux new-window -t $SESSION:4 -n 'Mongo'
tmux split-window -v
tmux select-pane -t 0
tmux send-keys "mongod --dbpath /host/_data" C-m
tmux select-pane -t 1
tmux send-keys "sleep 3 && /host/assets/clear-http-servers && mongo new_arqiva_manager_local" C-m


# And back to the main affair
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION

