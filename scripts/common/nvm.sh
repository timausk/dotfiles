#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# nvm.sh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../helper.sh"


print_info "- - - - - - - Install Node Version Manager  - - - - - - - - - - - - - - -"


# - - - - - - - - - - - - - - - - - - - - - - - - -
# Functions

install_nvm () {

  cd $HOME &&
  git clone --quiet https://github.com/creationix/nvm.git .nvm &&
  cd .nvm &&
  . $HOME/.nvm/nvm.sh &&
  print_action "cloned repository to ~/.nvm"

  add_nvm_config
  verify_nvm_installation
}


update_nvm () {

  print_action "update nvm"

  cd $HOME/.nvm &&
  git fetch --quiet origin &&
  git checkout --quiet &&
  . $HOME/.nvm/nvm.sh &&
  print_success "nvm updated"
}


add_nvm_config() {

  if [ ! -f $HOME/.zshrc.local ]; then
    print_warning ".zshrc.local created"
    touch $HOME/.zshrc.local;
  fi

  # add the necessary config to LOCAL shell config file (zshrc.local)

cat >> $HOME/.zshrc.local <<EOL
# - - Node Version Manager - - - - - - - - - - - - - - - - - - - - - - - - - -
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

EOL
}

## set some defaults to npm config
set_npm_defaults () {
  echo Type in your npm author\'s name and email.
  printf '%s ' 'name:'
  read -r authorName
  printf '%s ' 'email:'
  read -r authorEmail
  
  npm set init.author.name "$authorName"
  npm set init.author.email "$authorEmail"
  npm set init.license "MIT"
  npm set init.version "0.0.1"
}

## RFE extend list, extract to separate file + loop/ask s. brew.sh
install_npm_packages() {
  npm install -g svgo
}

verify_nvm_installation() {
  local verifyOutput=$(command -v nvm)

  if [[ verifyOutput = "nvm" ]]; then
    print_success "nvm installed and configured properly"
    set_npm_defaults
    install_npm_packages
  else
    print_warning "Verifying NVM failed. On Linux: close your current terminal,
           open a new terminal, and try verifying again ($ command -v nvm)"
  fi
}


install_latest_stable_node () {

  print_action "install latest stable node"

  # Install the latest stable version of Node
  # (this will also set it as the default).

  . $HOME/.zshrc.local && nvm install node
}


# - - - - - - - - - - - - - - - - - - - - - - - - -
# Run

if [ ! -d "$HOME/.nvm" ]; then
  install_nvm
else
  update_nvm
fi

install_latest_stable_node
