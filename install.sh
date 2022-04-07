#!/usr/bin/env zsh

STOW_FOLDERS="git,tmux,vim,shell,mac,url"

DOT_FILES=$HOME/.dotfiles

pushd $DOT_FILES
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done
popd
