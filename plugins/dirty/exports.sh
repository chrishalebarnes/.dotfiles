__dirty_echo() {
  if [ -d .git ]; then
    [[ $(git status --porcelain) ]] && echo -e "$1"
  fi;
}
