#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup-symlinks.sh

# This script creates symlinks from the home dir
# to any desired dotfiles
#
# RFE make path to dotfiles folder configurable
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

dirDotfile=$HOME/Development/dotfiles
dirDotfileBackup=$HOME/.dotfiles_backup


# list of dotfiles to symlink
declare -a FILES_TO_SYMLINK=(
  "editorconfig"
  "src/shell/zshrc"
  "src/git/gitignore"
)


# create a backup folder for existing dotfiles
if [ -d "$dirDotfileBackup" ]; then
  echo "backup folder already exist"
  exit 1
else
  mkdir $dirDotfileBackup
  echo -e "backup folder created"
fi


# loop through files and setting up symlinks
for i in "${FILES_TO_SYMLINK[@]}"; do

  # get filename from path
  dotfile=${i##*/}

  # backup and remove existing dotfile from ~
  if [ -f $HOME/.$dotfile ]; then
   cp $HOME/.$dotfile $dirDotfileBackup/.$dotfile
   rm $HOME/.$dotfile
   echo -e "Backed up and removed .$dotfile from ~"
  fi

  # create (if not exist) corresponding .local file
  if [ -f $HOME/.$dotfile.local ]; then
    echo -e "$dotfile.local already exist in ~"
  else
    echo -e ".$dotfile.local created"
    touch $HOME/.$dotfile.local
  fi

  pathToSymlink="$dirDotfile/$i"
  pathToFile="$HOME/.$dotfile"

  # create symlink
  ln -s $pathToSymlink $pathToFile

  echo -e "symlink for .$dotfile created"

done