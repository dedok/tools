#!/bin/bash

VIMRC=~/.vimrc
VIM_PLUGINS=~/.vim/plugins.vim
VUNDLE_PATH=~/.vim/bundle/vundle
PLUGINS_PATH=~/.vim/plugins.vim
REPO=https://github.com/gmarik/vundle.git

link vimrc $VIMRC || exit 3
link plugins.vim $VIM_PLUGINS || exit 4

([ -e $VUNDLE_PATH ] && {
    cd $VUNDLE_PATH && git pull origin master || exit 1
}) || {
    git clone $REPO $VUNDLE_PATH || exit 2
}

vim -u $PLUGINS_PATH -c 'BundleInstall!' -c 'qall'
