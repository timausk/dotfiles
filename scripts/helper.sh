#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# helper.sh
#
# shell helper function
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# - - - - - - - - - - - - - - - - - - - - - - - - -
# beautiful output

print_in_color() {
  printf "%b" \
    "$(tput setaf "$2" 2> /dev/null)" \
    "$1" \
    "$(tput sgr0 2> /dev/null)"
}

print_info() {
  print_in_cyan "=> $1\n"
}

print_success() {
  print_in_green "  => [✔] $1\n"
}

print_error() {
  print_in_red "  => [✖] $1 $2\n"
}

print_warning() {
  print_in_yellow "  => [!] $1\n"
}

print_action() {
  print_in_white "  => $1\n"
}

print_result() {

  if [ "$1" -eq 0 ]; then
    print_success "$2"
  else
    print_error "$2"
  fi

  return "$1"
}

print_in_green() {
  print_in_color "$1" 2
}

print_in_yellow() {
  print_in_color "$1" 3
}

print_in_red() {
  print_in_color "$1" 1
}

print_in_cyan() {
  print_in_color "$1" 6
}

print_in_white() {
  print_in_color "$1" 7
}

# - - - - - - - - - - - - - - - - - - - - - - - - -
# Ask for the admin password upfront

ask_for_sudo() {

  sudo -v &> /dev/null

  # Update existing `sudo` time stamp
  # until this script has finished.
  #
  # https://gist.github.com/cowboy/3118588

  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &
}


# - - - - - - - - - - - - - - - - - - - - - - - - -
# get OS

get_os() {

  local os=""
  local kernelName=""

  kernelName="$(uname -s)"

  if [ "$kernelName" == "Darwin" ]; then
    os="macos"
  elif [ "$kernelName" == "Linux" ]; then
    os="linux"
  else
    os="$kernelName"
  fi

  printf "%s" "$os"
}
