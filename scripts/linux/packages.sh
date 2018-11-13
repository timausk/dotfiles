#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# packages.sh
#
# Installing packages/software
# this includes allmost any package we would install on mac via brew
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../helper.sh"

print_info "- - - - - - - Install Packages - - - - - - - - - - - - - - - - - - - - -"


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing vim
./packages/vim.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing webstorm
./packages/atom.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing keepassX
./packages/keepassx.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing guake
./packages/guake.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing ovpn
./packages/ovpn.sh
