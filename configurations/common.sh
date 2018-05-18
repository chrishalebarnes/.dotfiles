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
