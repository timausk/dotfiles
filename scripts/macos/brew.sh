#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# brew.sh
#
# Installing homebrew + packages and casks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$(dirname "${BASH_SOURCE[0]}")" \ && . "../helper.sh"

# todo
#      info xcode, please confirm prompt
print_info "- - - - - - - Install Homebrew - - - - - - - - - - - - - - - - - - - - -"

print_in_yellow "Use alternative installation directory (only recommend if /usr/local is locked down) [Yes|No]?\n"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      read -p "Install to directory ~/.homebrew [Y | any other key to exit]  `echo $'\n> '`" -n 1 -r
      echo #new line
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_action "install homebrew to alternative directory ~/.homebrew";
        mkdir $HOME/.homebrew &&
        curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C $HOME/.homebrew
        export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH
        break
      fi
    ;;
    No )
      read -p "Install to default folder /usr/local [Y | any other key to exit]  `echo $'\n> '`" -n 1 -r
      echo #new line
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_action "install homebrew to /usr/local";
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        break
      fi
    ;;
    * )
      print_in_red "Please select Yes or No!"
    ;;
    esac
done

brew update && brew upgrade

# make cask available
brew tap homebrew/cask

# install packages
brew_pkg=(
  git
  zsh
  zsh-completions
)

brew install "${brew_pkg[@]}"


# install casks
brew_casks=(
  appcleaner
  atom
  google-chrome
  google-backup-and-sync # google drive
  skype
  # ToDo find a way to handle the annoying KEXT security error
  #virtualbox
  #vagrant
  #vagrant-manager
  webstorm
)

: '
if [[ ${brew_casks[@]} = *"virtualbox"* ]]; then
read -p "We are going to install virtualbox.
Please allow installing software from developer \"Oracle ..\" before continuing!
System Preferences > Security & Privacy.
[hit any key to carry on]"
fi
'

brew cask install "${brew_casks[@]}"