#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# download robo3T, extract tar and mv to local/bin/robo3t folder
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Robo3T version
version="robo3t-1.2.1-linux-x86_64-3e50a65"
downloadPath=$HOME/Downloads

# download
wget https://download.robomongo.org/1.2.1/linux/$version.tar.gz -P $downloadPath

# extract
tar -xvzf $downloadPath/$version.tar.gz -C $downloadPath

# create robo3t folder
sudo mkdir /usr/local/bin/robo3t

# mv extracted files into robo3t folder
sudo mv $downloadPath/$version/* /usr/local/bin/robo3t

# check if robo3T folder is empty
if [ -z "$(ls -A /usr/local/bin/robo3t)" ]; then
   echo "Oops, seams that something went wrong installing robo3T"
else
   echo "Robo3T successfully installed! run: $ runrobot3"
   # cleanup
   rm $downloadPath/$version.tar.gz && rm -rf $downloadPath/$version
fi


# TODO add to favorites or create a desktop shortcut
#      => https://linuxconfig.org/how-to-create-desktop-shortcut-launcher-on-ubuntu-18-04-bionic-beaver-linux
