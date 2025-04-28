#!/bin/sh

# Make sure the theme dir exists
mkdir -p ~/.config/tmux/plugins/catppuccin

# Only clone the script if it doesn't already exist
if [ ! -d ~/.config/tmux/plugins/catppuccin/tmux ]; then
	git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi
