export AUTOSSH_PORT=22222
export PATH="${PATH}:${HOME}/bin"
export CLICOLOR=1

source ${HOME}/.mybashrc.sh

ssh-add ${HOME}/.ssh/*.id_rsa
ssh-add ${HOME}/.ssh/*.key
ssh-add ${HOME}/.ssh/*.pem

alias ll='ls -lah'
#alias diff='colordiff'

sublime_text_extend() {
  local VERSION=3
  (cd ~/Library/Application\ Support/Sublime\ Text\ $VERSION/Packages &&\
    git clone git@github.com:sublimehq/Vintage.git "Vintage Dev")\
  || echo "sublime_text_extend: failed"
  cd - 2>/dev/null
}

gdb() {
  echo "[+] Runs the lldb"
  PATH=/usr/bin /usr/bin/lldb $@
}

export PATH="/usr/local/sbin:$PATH"
alias allparts='cd /Users/dedok/workspace/allparts/backend'
export LD_LIBRARY_PATH=/Users/vasilysoshnikov/Downloads/instantclient_12_1/
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
