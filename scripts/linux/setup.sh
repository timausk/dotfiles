#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# brew.sh
#
# setup a new LINUX machine
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
cd "$(dirname "${BASH_SOURCE[0]}")" && . "../helper.sh"

# setup SSH
# i downloaded and copied files, but guess we should gen a new pair
# copy downloaded files
# cp ~/Downloads/id_rsa.pub ~/.ssh/
# correct permission
# sudo chmod 600 ~/.ssh/id_rsa




# update packagelist upfront
sudo apt update;
# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing packages
./packages.sh


# - - - - - - - - - - - - - - - - - - - - - - - - -
# installing oh-my-zsh
./../common/oh_my_zsh.sh
