#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup.sh
#
# setup a new MAC machine
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
. "helper.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing XCode

./macos/xcode.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing homebrew packages + casks

./macos/brew.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# update OS

print_info "- - - - - Update OS - - - - - - - - - - - - - - - - - - - - - - - - - -"
sudo softwareupdate -i -a
