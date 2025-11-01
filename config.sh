#!/bin/bash
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.bak
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.vimrc ~/.vimrc.bak
mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s ./config.fish ~/.config/fish/config.fish
ln -s ./config.nvim ~/.config/nvim
ln -s ./tmux.conf ~/.tmux.conf
ln -s ./vimrc ~/.vimrc
