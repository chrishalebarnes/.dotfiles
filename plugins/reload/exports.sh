reload() {
  if [[ $OSTYPE == *"darwin"* ]]; then
    source ~/.bash_profile
  else
    source ~/.bashrc
  fi
}
