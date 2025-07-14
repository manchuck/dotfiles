export PATH="$HOME/bin:$PATH:/usr/local/bin";
export NVM_DIR="$HOME/.nvm"
export PROJECT_PATHS=(~/Projects/ ~/Projects/vonage/SDK ~/Projects/vonage/demo ~/Projects/vonage/snippets ~/Projects/vonage/tools ~/Projects/vonage/content/blog ~/Projects/vonage/talks ~/Projects/vonage/content ~/Projects/vonage/SDK)
export TZ=America/New_York
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PYENV_ROOT="$HOME/.pyenv"
export WALK_EDITOR='nvim'
export PATH="$HOME/.serverless/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [[ -d "/opt/homebrew/opt/llvm/" ]] ; then
  export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
fi
