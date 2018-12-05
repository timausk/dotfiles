#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# install smart-git client
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

downloadPath=$HOME/Downloads

wget https://www.syntevo.com/downloads/smartgit/smartgit-18_1_5.deb -P $downloadPath &&
sudo apt install $downloadPath/smartgit-18_1_5.deb &&
rm $downloadPath/smartgit-18_1_5.deb
