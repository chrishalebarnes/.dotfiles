export CLICOLOR=1
export LSCOLORS="exfxcxdxbxegedabagacad"
export GREP_COLOR='1;33'
export PATH=/usr/local/bin:$PATH

# Workaround for option-arrow keys not skipping words in https://github.com/randy3k/Terminus on macOS
if [ $TERM_PROGRAM == "Terminus-Sublime" ]; then
  bind '"\e[1;3C": forward-word'
  bind '"\e[1;3D": backward-word'
fi

source ~/.dotfiles/configurations/common.sh
