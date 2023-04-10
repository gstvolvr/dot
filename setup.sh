#!/bin/bash

set -ex

SCRIPT=`readlink -f $0`
SCRIPT_DIR=`dirname $SCRIPT`

dotvim=${SCRIPT_DIR}/dotvim
dotbash=${SCRIPT_DIR}/dotbash

curl -fLo $dotvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# create necessary directories
mkdir -p ~/.vim-tmp

# remove existing vim configs
rm -rf ~/.vim
rm -rf ~/.vimrc

# organize symlinks
ln -sf $dotvim/vimrc ~/.vimrc
ln -sf $dotvim ~/.vim

ln -sf $dotbash/bashrc ~/.bashrc
ln -sf $dotbash/bash_aliases ~/.bash_aliases

# run updates
vim +PlugInstall +qall
