#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup-symlinks.sh
#
# This script creates symlinks from the home dir
# to any desired dotfiles
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

dirDotfilesRoot=`dirname $PWD`;
dirDotfilesBackup=$HOME/.dotfiles_backup
platform=$(uname)

if [ ! -f $HOME/.zshenv ]; then
  touch $HOME/.zshenv;
fi

echo "DOTFILESROOT=$dirDotfilesRoot" >> $HOME/.zshenv
if [[ $platform == "Darwin" ]]; then
  echo "# set custom path for cesk applications" >> $HOME/.zshenv
  echo export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications" >> $HOME/.zshenv
fi

# list of dotfiles to symlink
declare -a FILES_TO_SYMLINK=(
  "editorconfig"
  "src/shell/zshrc"
  "src/git/gitignore"
)

# create a backup folder for existing dotfiles
if [ -d "$dirDotfilesBackup" ]; then
  echo "backup folder already exist"
  exit 1
else
  mkdir $dirDotfilesBackup
  echo -e "backup folder created"
fi


# loop through files and setting up symlinks
for i in "${FILES_TO_SYMLINK[@]}"; do

  # get filename from path
  dotfile=${i##*/}

  # backup and remove existing dotfile from ~
  if [ -f $HOME/.$dotfile ]; then
   cp $HOME/.$dotfile $dirDotfilesBackup/.$dotfile
   rm $HOME/.$dotfile
   echo -e "Backed up and removed .$dotfile from ~"
  fi

  # create (if not exist) corresponding .local file
  if [ -f $HOME/.$dotfile.local ]; then
    echo -e "$dotfile.local already exist"
  else
    echo -e ".$dotfile.local created"
    touch $HOME/.$dotfile.local
  fi

  pathToSymlink="$dirDotfilesRoot/$i"
  pathToFile="$HOME/.$dotfile"

  # create symlink
  ln -s $pathToSymlink $pathToFile

  echo -e "symlink for .$dotfile created"

done

if [! -f $HOME/.zshenv ]; then
echo 'create file'
fi
