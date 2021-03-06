#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# packages.sh
#
# Installing packages/software
# this includes allmost any package we would install on mac via brew + some basic
# packages which are not included in ubuntus minimal installation
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../helper.sh"

print_info "- - - - - - - Install Packages - - - - - - - - - - - - - - - - - - - - -"


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing vim
./packages/vim.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing command line tools
./packages/commandlinetools.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing atom
./packages/atom.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing keepassX
./packages/keepassx.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing guake
./packages/guake.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing robo3T
./packages/robo3t.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing mongodb
./packages/mongodb.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing gitGui
./packages/gitgui.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing ovpn
./packages/ovpn.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing office
./packages/office.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing pinta
# (!) see comment in pinta.sh
#./packages/pinta.sh
