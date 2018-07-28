#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# brew.sh
#
# setup a new machine
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Load helper functions

cd "$(dirname "${BASH_SOURCE[0]}")" \ && . "helper.sh" || exit 1;


# - - - - - - - - - - - - - - - - - - - - - - - - -
# verify OS

os="$(get_os)"

if [[ ! $os =~ ^(macos|linux)$ ]]; then
  print_error "Platform not supported (kernelName = $os)!"
  exit 1;
fi

print_in_green "Setup new machine [$os]\n"

print_in_red "DO NOT continue if you not fully understand what it does! "
read -p "(Y to continue or any other key to exit) `echo $'\n> '`" -n 1 -r
echo #new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1;
fi

print_in_white "Please enter your Password\n"


# - - - - - - - - - - - - - - - - - - - - - - - - -
# ask for sudo upfront
ask_for_sudo


# - - - - - - - - - - - - - - - - - - - - - - - - -
# setup symlinks

./setup-symlinks.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# setup system

"./$(get_os)/setup.sh"

print_in_green "DONE";
