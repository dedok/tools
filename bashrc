export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

if [ ! -z "$PS1" ]; then
  export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$ \[\e[m\]'
else
  export PS1=''
fi

PATH=$PATH:$HOME/bin

alias ll="ls -h"
alias fcc="grep -R --include=\*.{c,cpp,cxx,cc,h,hpp,hxx,m} --include=Makefile --include=CMakeLists.txt --color -n"
alias ftc="grep -R --include=\*.{tmpl,inc} --color -n"

gbranch() {
  local bname=`git status -s -b | head -n1 | sed -e "s/##.//g"`
  echo $bname
}

gpush() {
  git push origin `gbranch`;
}

gpull() {
  git pull origin `gbranch`;
}

gstat() {
  git status
}

cmake_help() {
  cmake --help-command "$@" | less
}
