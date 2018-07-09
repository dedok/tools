#!/bin/bash
#
# (C) V. Soshnikov
#


if [ x$(which brew) == x'' ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo '[+] Installing tools'
brew install ctags
brew install cscope
brew install node
brew install tmux
brew install cmake

echo '[+] Installing scripts'
cp $PWD/bash_profile $HOME/.bash_profile
cp $PWD/bashrc $HOME/.mybashrc.sh
cp $PWD/gitconfig $HOME/.gitconfig

echo '[+] Installing VIM'
cd vim
./setup.sh

exit 0

