for source in /usr/share/bash-completion/completions/git /usr/lib/git-core/git-sh-prompt /usr/local/etc/bash_completion.d/git-completion.bash /usr/local/etc/bash_completion.d/git-prompt.sh; do
  if [ -e $source ]; then
    source $source
  fi
done
