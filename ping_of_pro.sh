#!/bin/bash
tmux new -s pingfesta -d

tmux split-window -v -t pingfesta.0
tmux split-window -v -t pingfesta.0
tmux split-window -v -t pingfesta.0
tmux split-window -v -t pingfesta.0
tmux select-layout -t pingfesta.0 even-vertical
tmux select-pane -t pingfesta.0
tmux split-window -h
tmux select-pane -t pingfesta.2
tmux split-window -h
tmux select-pane -t pingfesta.4
tmux split-window -h
tmux select-pane -t pingfesta.6
tmux split-window -h
tmux select-pane -t pingfesta.8
tmux split-window -h

tmux send-keys -t pingfesta.0 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.1 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.2 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.3 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.4 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.5 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.6 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.7 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.8 'powershell.exe ping -t -w 1 1.1.1.1' C-m
tmux send-keys -t pingfesta.9 'powershell.exe ping -t -w 1 1.1.1.1' C-m