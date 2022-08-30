#!/usr/bin/env zsh

COMPUTER_NAME="WOPR"
BREW_PACKAGES="git,pyenv,kubectl,nvm,stow,vim,autoenv,pyenv-virtualenv,cmake,python,go,nodejs"
STOW_FOLDERS="git,tmux,vim,shell,mac,url"
DOT_FILES=$HOME/.dotfiles

echo "Installing home brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/manchuck/.zprofile\n    eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing brew packages"
for package in $(echo $BREW_PACKAGES | sed "s/,/ /g")
do
    brew install $package
done

echo "Setting dotfiles"
pushd $DOT_FILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done
popd

echo "Creating SSH keys"
ssh-keygen -t ed25519 -C $COMPUTER_NAME

echo "Installing Pk10"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

echo "Mkaing directories"
mkdir -p ~/.vim/backup ~/.vim/swaps ~/.vim/undo ~/Projects

echo "Installing bim plugins"
vim +PluginInstall +qall
