#!/bin/bash

set -ex

dotvim=~/src/gstvolvr/dot/dotvim
dotnvim=~/src/gstvolvr/dot/dotnvim
dotbash=~/src/gstvolvr/dot/dotbash
dottmux=~/src/gstvolvr/dot/dottmux

curl -fLo $dotvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create necessary directories
mkdir -p ~/.vim-tmp

# remove existing vim configs
rm -rf ~/.vim
rm -rf ~/.vimrc

# organize symlinks
ln -sf $dotvim/vimrc ~/.vimrc
ln -sf $dotvim ~/.vim

mkdir -p .config/nvim
ln -sf $dotnvim/init.vim ~/.config/nvim/init.vim

ln -sf $dotbash/bashrc ~/.bashrc
ln -sf $dotbash/bash_aliases ~/.bash_aliases

ln -sf $dottmux/tmux.conf ~/.tmux.conf

# run updates
vim +PlugInstall +qall
