#!/bin/bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# helper.sh
#
# shell helper function
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

print_success() {
  print_in_green "   [✔] $1\n"
}

print_error() {
  print_in_red "   [✖] $1 $2\n"
}

print_warning() {
    print_in_yellow "   [!] $1\n"
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
