#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# brew.sh
#
# Installing homebrew + packages and casks
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../helper.sh"


print_info "- - - - - - - Install Homebrew - - - - - - - - - - - - - - - - - - - - -"

print_in_yellow "Use alternative installation directory (only recommend if /usr/local is locked down) [Yes|No]?\n"
select yn in "Yes" "No"; do
  case $yn in
    Yes )
      read -p "Install to directory ~/.homebrew [Y | any other key to exit]  $(echo $'\n> ')" -n 1 -r
      echo #new line
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_action "install homebrew to alternative directory ~/.homebrew";
        mkdir "$HOME"/.homebrew &&
        curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C "$HOME"/.homebrew
        export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH
        break
      fi
    ;;
    No )
      read -p "Install to default folder /usr/local [Y | any other key to exit]  $(echo $'\n> ')" -n 1 -r
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

# make cask repos available
brew tap homebrew/cask

# make cask versions available (required for installing some casks like ff-developer-version, chrome
brew tap homebrew/cask-versions

# install packages
declare -a brew_pkg=(
  composer
  ffmpeg
  htop
  git
  go
  maven
  mongodb
  php70
  youtube-dl
  zsh
  zsh-completions
)

declare -a brew_pkg_install=()

for package in "${brew_pkg[@]}"
do
   read -p "Install $package ? [Y|*]?" -n 1 -r
   echo #new line
   if [[ $REPLY =~ ^[Yy]$ ]]; then
     print_in_green "$package \n"
     brew_pkg_install+=("$package")
   else
     print_in_red "\e[9m$package\e[0m\n"
   fi
done

print_in_yellow "The following packages will be installed via homebrew => ${brew_pkg_install[*]} \n"


brew install "${brew_pkg_install[@]}"


# install casks
# - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_yellow "Install CASKs to users local application dir (Users/$(whoami)/Applications)"
read -p "[Y|N]? $(echo $'\n> ')" -n 1 -r
echo #new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! -f "$HOME/.zshenv" ]; then
    touch "$HOME/.zshenv";
  fi

  echo "export HOMEBREW_CASK_OPTS=--appdir=/Users/$(whoami)/Applications" >> "$HOME/.zshenv"
  # shellcheck source=/dev/null
  . "$HOME/.zshenv"
fi

declare -a brew_casks=(
  anydesk
  appcleaner
  atom
  brave-browser
  charles
  cyberduck
  docker
  epic
  firefox
  firefox-developer-edition
  fork
  google-chrome
  google-chrome-canary
  google-backup-and-sync # google drive
  ghostscript
  hugo
  intellij-idea # ultimate edition
  imageoptim
  iterm2
  java # this installs the latest version!
  keepassx
  postman
  robo-3t # robomongo
  skype
  steam
  the-unarchiver
  tunnelblick
  # ToDo find a way to handle the annoying KEXT security error
  #virtualbox
  #virtualbox-extension-pack
  #vagrant
  #vagrant-manager
  vlc
  webstorm
)

declare -a brew_casks_install=()

for casks in "${brew_casks[@]}"
do
   read -p "Install $casks ? [Y|*]?" -n 1 -r
   echo #new line
   if [[ $REPLY =~ ^[Yy]$ ]]; then
     print_in_green "$casks \n"
     brew_casks_install+=("$casks")
   else
     print_in_red "\e[9m$package\e[0m\n"
   fi
done

print_in_yellow "The following packages will be installed via homebrew => ${brew_casks_install[*]}"

# shellcheck disable=SC2016
: '
if [[ ${brew_casks[@]} = *"virtualbox"* ]]; then
read -p "We are going to install virtualbox.
Please allow installing software from developer \"Oracle ..\" before continuing!
System Preferences > Security & Privacy.
[hit any key to carry on]"
fi
'

brew cask install "${brew_casks_install[@]}"
