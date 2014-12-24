export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

if [ ! -z "$PS1" ]; then
  export PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$ \[\e[m\]'
else
  export PS1=''
fi

alias ll="ls -h"
alias ss="cd $HOME/stat/sources"

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

gcommit() {
  ## $1 = message, $2-N files
  local no=0
  local msg=no
  local args=
  for x in $@; do
    if [[ $no == 0 ]]; then
      msg=$x;
    else
      args="$args $x";
    fi
    (( no++ ))
  done
  [[ $msg == no ]] && { echo "error: empty commit message"; return; }
  [[ $no == 0 ]] && { echo "error: empty files to commit"; return; }

  git commit -m "$issue, $msg" $args
}

gstat() {
  git status
}

cmake_help() {
  cmake --help-command "$@" | less
}
