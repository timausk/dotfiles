#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup-symlinks.sh
#
# This script creates symlinks from the home dir
# to any desired dotfiles
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$(dirname "${BASH_SOURCE[0]}")" && . "helper.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Functions

create_symlinks() {
  dirDotfilesRoot=`dirname $PWD`;
  dirDotfilesBackup=$HOME/.dotfiles_backup

  if [ ! -f $HOME/.zshenv ]; then
    touch $HOME/.zshenv;
  fi

  echo "DOTFILESROOT=$dirDotfilesRoot" >> $HOME/.zshenv

  # list of dotfiles to symlink
  declare -a FILES_TO_SYMLINK=(
    "src/shell/zshrc"

    "src/git/gitconfig"
    "src/git/gitignore"

    "src/atom/config.cson"
    "src/atom/init.coffee"
    "src/atom/keymap.cson"
    "src/atom/snippets.cson"
    "src/atom/styles.less"

    "src/editorconfig"
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
     print_action "Backed up and removed .$dotfile from ~"
    fi

    pathToSymlink="$dirDotfilesRoot/$i"
    # RFE improve
    pathToFile=$([[ $i = *"atom"* ]] && echo $HOME/.atom/$dotfile || echo $HOME/.$dotfile)

    # create symlink
    ln -s $pathToSymlink $pathToFile

    print_action "symlink for .$dotfile created"

  done
}

create_local_config_files() {

  declare -a CONFIG_FILES=(
    "editorconfig"
    "gitconfig"
    "gitignore"
    "zshrc"
  )

  for i in "${CONFIG_FILES[@]}"; do

    file=".$i.local"

    if [ -f $HOME/$file ]; then
      print_action "$file already exist"
    else
      print_action "$file created"
      touch $HOME/$file
    fi

  done
}

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Run
#
print_info "- - - - - - - Create symbolic links - - - - - - - - - - - - - - - - - - -"

create_symlinks
create_local_config_files
