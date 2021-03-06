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

if [ -x "$(command -v gcloud)" ]; then
  gcloud config set disable_usage_reporting true
fi

export DO_NOT_TRACK=1

# Adds current directory node executables to path
export PATH=./node_modules/.bin:$PATH
