#!/bin/bash

tmux new-session -d -c '/localdisk/hmuresan/yocto/source/valimar/ciena/hal'
tmux start-server
tmux select-window -t 0:0
tmux split-window -h -c '/localdisk/hmuresan/yocto/source/valimar2/ciena/hal'
tmux select-pane -t 0
tmux split-window -v -c '/localdisk/hmuresan/yocto/builds/valimar/'
tmux split-window -v -c '/localdisk/hmuresan/yocto/source/valimar3/ciena/hal'
tmux split-window -v -c '/localdata/hmuresan/yocto/builds/valimar3/'
tmux select-pane -t 4
tmux split-window -v -c '/localdata/hmuresan/yocto/builds/valimar2/'


tmux new-window  -t 0:1 
tmux select-window -t 0:1
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 2
tmux split-window -h

tmux new-window  -t 0:2
tmux select-window -t 0:2
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 2
tmux split-window -h


tmux new-window  -t 0:3 
tmux select-window -t 0:3
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 2
tmux split-window -h

tmux new-window  -t 0:4 
tmux select-window -t 0:4
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 2
tmux split-window -h

tmux new-window  -t 0:5 
tmux select-window -t 0:5
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 2
tmux split-window -h

tmux new-window  -t 0:6 
tmux select-window -t 0:6
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 2
tmux split-window -h

tmux new-window  -t 0:7  'python3'

tmux new-window  -t 0:8 -c '/home/hmuresan/scratch/'
tmux select-window -t 0:8 
tmux split-window -v -c '/home/hmuresan/scratch'

tmux new-window -t 0:9 -c '/home/hmuresan/from_device/'
tmux select-window -t 0:9
tmux split-window -v -c '/home/hmuresan/from_device/'

tmux select-window -t 0:0

tmux -2 attach-session -t 0
