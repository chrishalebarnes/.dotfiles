source ~/.dotfiles/sources/plugins.sh

__dotfiles_update_ps1() {
  # Check for existence of this function, print a plain prompt if it doesn't exist
  export PS1="\$(declare -F __dotfiles_update_ps1 &>/dev/null && echo \"${WHITE}\u@\h:${BLUE}\w${RESET}${GREEN}\$(__git_ps1 '(%s$(__dirty_echo ${RED}*${GREEN}))')${RESET}|$(__versions_echo)${WHITE}\\$ ${RESET}\" || echo \"${WHITE}\u@\h:${BLUE}\w${RESET}${WHITE}\\$ ${RESET}\")"
}

__dotfiles_update_prompt_command() {
  declare -F update_terminal_cwd &>/dev/null && update_terminal_cwd # Terminal.app has update_terminal_cwd
  __dotfiles_update_ps1
}

export PROMPT_COMMAND='__dotfiles_update_prompt_command'

export VISUAL=nano
export EDITOR="$VISUAL"

# Opt out of TUI and CLI tracking: https://consoledonottrack.com/
export GATSBY_TELEMETRY_DISABLED=1
export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export SAM_CLI_TELEMETRY=0
export AZURE_CORE_COLLECT_TELEMETRY=0
export DO_NOT_TRACK=1

if [ -x "$(command -v gcloud)" ]; then
  gcloud config set disable_usage_reporting true
fi

# Adds current directory node executables to path
export PATH=./node_modules/.bin:$PATH

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
