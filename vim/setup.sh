#!/usr/bin/env bash

VIMRC="${HOME}/.vimrc"
VIM_DIR="${HOME}/.vim"
VIM_PLUGINS="${VIM_DIR}/plugins.vim"
VUNDLE_PATH="${VIM_DIR}/bundle/vundle"
PLUGINS_PATH="${VIM_DIR}/plugins.vim"
REPO=https://github.com/gmarik/vundle.git

[ ! -d $VIM_DIR ] && mkdir -p $VIM_DIR

link vimrc $VIMRC &> /dev/null
link plugins.vim $VIM_PLUGINS &> /dev/null

([ -e $VUNDLE_PATH ] && {
    cd $VUNDLE_PATH && git pull origin master || exit 1
}) || {
    git clone $REPO $VUNDLE_PATH || exit 2
}

touch $VIM_DIR/localrc.vim || exit 3

vim -u $PLUGINS_PATH -c 'BundleInstall!' -c 'qall'

