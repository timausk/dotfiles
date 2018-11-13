# install ovpn + req. packages and restart the network manager
sudo apt install openvpn network-manager-openvpn network-manager-openvpn-gnome -y && sudo service network-manager restart

# (!) restarting the network-manager should make it possible to load ovpn files without reboot the system
