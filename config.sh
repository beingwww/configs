#!/bin/bash
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.bak
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.vimrc ~/.vimrc.bak
mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s ~/configs/config.fish ~/.config/fish/config.fish
ln -s ~/configs/config.nvim ~/.config/nvim
ln -s ~/configs/tmux.conf ~/.tmux.conf
ln -s ~/configs/vimrc ~/.vimrc
