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

echo '[+] Installing scripts'
cp $PWD/bash_profile $HOME/.bash_profile
cp $PWD/bashrc $HOME/.mybashrc.sh

echo '[+] Installing VIM'
cd vim
./setup.sh

exit 0

