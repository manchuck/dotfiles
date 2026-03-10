# Path to your oh-my-zsh installation.

plugins=(
  aliases
  autoenv
  aws
  brew
  colorize
  common-aliases
  composer
  copyfile
  cp
  dash
  emotty
  git
  github
  gitignore
  history
  jsontools
  macos
  node
  npm
  pj
  python
  rsync
  yarn
  zsh-nvm
)

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

export NVM_LAZY_LOAD=true

source $ZSH/oh-my-zsh.sh

autoload bashcompinit && bashcompinit

autoload -Uz compinit && compinit

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

[ -f "$XDG_CONFIG_HOME/shell/alias" ] && source "$XDG_CONFIG_HOME/shell/alias"
[ -f "$XDG_CONFIG_HOME/shell/vars" ] && source "$XDG_CONFIG_HOME/shell/vars"

export PATH="$PATH:$HOME/.local/bin"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
