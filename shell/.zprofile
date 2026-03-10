export EDITOR="nvim"

# follow XDG base dir specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# add scripts to path
export PATH="$XDG_CONFIG_HOME/scripts:$PATH"

# history files
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export PYTHON_HISTORY="$XDG_DATA_HOME/python/history"


# setting up applications for XDG
export ZSH=$XDG_DATA_HOME/.oh-my-zsh
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$HOME/.nvm"
export FFMPEG_DATADIR="$XDG_CONFIG_HOME/ffmpeg"
export DATE=$(date "+%A, %B %e  %_I:%M%P")
export PHP_HISTFILE="$XDG_STATE_HOME"/php/history
export SQLITE_HISTORY=$XDG_STATE_HOME/sqlite_history
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship.toml
export STARSHIP_CACHE="$XDG_CACHE_HOME"/starship
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"

export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview" # separate opts for history widget
export MANPAGER="less -R --use-color -Dd+r -Du+b" # colored man pages

export TZ=America/New_York
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$HOME/bin:/usr/local/bin:$PATH

export HIST_STAMPS="yyyy-mm-dd"

export PATH="$HOME/bin:$PATH:/usr/local/bin";

export PROJECT_PATHS=(~/Projects/ ~/Projects/vonage ~/Projects/vonage/sdkProjects/vonage/demo ~/Projects/vonage/snippets ~/Projects/vonage/tools ~/Projects/vonage/content/blog ~/Projects/vonage/talks ~/Projects/vonage/content ~/Projects/vonage/SDK)
export PATH="$HOME/.serverless/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [[ -d "/opt/homebrew/opt/llvm/" ]] ; then
  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
fi

eval "$(/opt/homebrew/bin/brew shellenv zsh)"

