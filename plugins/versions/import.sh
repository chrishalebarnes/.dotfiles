__versions_echo() {
  if [ -f ~/.dotfiles/plugins/versions/versions.conf ]; then
    while read -r line; do
      IFS=, read comm name trims <<< "${line}"
      # Note: `java -version` prints to stderr, so the usual 2>/dev/null will not work
      if [[ $comm == *"java -version"* && $(type -p java) ]]; then
        local version=$(${comm} 2>&1)
        echo -e "${name}@$(echo $version | grep -o ${trims} | head -1)|\c"
      else
        local version=$(${comm} 2>/dev/null)
        if [ -n "${version}" ]; then
          echo -e "${name}@$(echo $version | grep -o ${trims})|\c"
        fi
      fi
    done < ~/.dotfiles/plugins/versions/versions.conf
  fi;
}
