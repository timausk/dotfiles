#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# sdkman.sh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cd "$(dirname "${BASH_SOURCE[0]}")" && . "../helper.sh"

print_info "- - - - - - - Install SDKMAN  - - - - - - - - - - - - - - -"

cd "$HOME" &&
curl -s "https://get.sdkman.io" | zsh &&
source "$HOME/.sdkman/bin/sdkman-init.sh" &&
sdk install java 17.0.2-zulu

version=$(sdk version)

print_success "${version} successfully installed"
