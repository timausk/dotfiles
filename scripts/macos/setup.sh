#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# setup.sh
#
# setup a new MAC machine
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$(dirname "${BASH_SOURCE[0]}")" \ && . "../helper.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing XCode

./xcode.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing homebrew packages + casks

./brew.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing node version manager

./../common/nvm.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# update OS

print_info "- - - - - Update OS - - - - - - - - - - - - - - - - - - - - - - - - - -"
sudo softwareupdate -i -a
