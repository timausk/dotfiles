#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# nvm.sh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../helper.sh"


print_info "- - - - - - - Install Oh My Zsh - - - - - - - - - - - - - - - - - - - - -"


# - - - - - - - - - - - - - - - - - - - - - - - - -
# Functions

is_zsh_installed () {
  if ! command -v zsh >/dev/null 2>&1; then
    print_warning "Zsh is not installed! Please install zsh first!"
    # TODO installl if not pre installed!
    # if we use ubuntus new minimal installation, which is available since ubuntu 18.04,
    # we have no zsh ! on mac it should alvays be pre installed, I guess..!?
    # check not installed cases and update script
    # on linux we can use apt install zsh
    exit 1
  fi
}


is_oh_my_zsh_installed () {
  if [ -d "$ZSH" ]; then
    print_warning "Oh My Zsh is already installed"
    exit 1
  fi
}


install_oh_my_zsh () {
  # clone repo
  cd "$HOME" && git clone --quiet https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  # create config file if not already exist
  if [ ! -f "$HOME"/.zshrc ]; then
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
  fi
}


change_current_shell () {

  # https://github.com/robbyrussell/oh-my-zsh/blob/master/tools/install.sh

  TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')

  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      print_action "Time to change your default shell to zsh!"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    # Else, suggest the user do so manually.
    else
      print_warning "I can't change your shell automatically because this system does not have chsh."
    fi
  fi
}


# - - - - - - - - - - - - - - - - - - - - - - - - -
# Run

is_zsh_installed
is_oh_my_zsh_installed
install_oh_my_zsh
change_current_shell
