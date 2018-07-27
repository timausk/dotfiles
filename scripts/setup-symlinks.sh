#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup-symlinks.sh
#
# This script creates symlinks from the home dir
# to any desired dotfiles
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
. "helper.sh"

print_info "- - - - - - - Create symbolic links - - - - - - - - - - - - - - - - - - -"

dirDotfilesRoot=`dirname $PWD`;
dirDotfilesBackup=$HOME/.dotfiles_backup

if [ ! -f $HOME/.zshenv ]; then
  touch $HOME/.zshenv;
fi

echo "DOTFILESROOT=$dirDotfilesRoot" >> $HOME/.zshenv

# list of dotfiles to symlink
declare -a FILES_TO_SYMLINK=(
  "editorconfig"
  "src/shell/zshrc"
  "src/git/gitignore"
)

# create a backup folder for existing dotfiles
if [ -d "$dirDotfilesBackup" ]; then
  print_warning "backup folder already exist"
  exit 1
else
  mkdir $dirDotfilesBackup
  print_action "backup folder created"
fi


# loop through files and setting up symlinks
for i in "${FILES_TO_SYMLINK[@]}"; do

  # get filename from path
  dotfile=${i##*/}

  # backup and remove existing dotfile from ~
  if [ -f $HOME/.$dotfile ]; then
   cp $HOME/.$dotfile $dirDotfilesBackup/.$dotfile
   rm $HOME/.$dotfile
   print_action"Backed up and removed .$dotfile from ~"
  fi

  # create (if not exist) corresponding .local file
  if [ -f $HOME/.$dotfile.local ]; then
    print_action "$dotfile.local already exist"
  else
    print_action ".$dotfile.local created"
    touch $HOME/.$dotfile.local
  fi

  pathToSymlink="$dirDotfilesRoot/$i"
  pathToFile="$HOME/.$dotfile"

  # create symlink
  ln -s $pathToSymlink $pathToFile

  print_action "symlink for .$dotfile created"

done
