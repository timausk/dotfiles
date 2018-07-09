#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# brew.sh
#
# Installing homebrew + packages and casks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

echo "homebrew installation"

echo "Use alternative installation directory (only recommend if /usr/local is locked down) [Yes|No]?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )
          echo "install homebrew to alternative directory ~/.homebrew";
          mkdir $HOME/.homebrew &&
          curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C $HOME/.homebrew
          export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATHbreak
          break
        ;;
        No )
          echo "install homebrew to /usr/local";
          /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
          break
        ;;
        * )
          echo "Please select Yes or No!"
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
