#!/bin/bash

thisdir=$(dirname "${BASH_SOURCE[0]}")
SCRIPT_DIR=$(cd -P -- "$thisdir" && pwd -P)
BUILDPACK_DIR=$(cd -P -- "$thisdir/../.." && pwd -P)

#  Source variables and override with platform specifics.
source "$BUILDPACK_DIR/lib/vars.sh"
source "$SCRIPT_DIR/vars.sh"



#
#  Prints the specified message - formatted.
#
#  Examples:
#    print_message "Initializing ..."
#
function print_message() {
  echo "$@" | sed "s/^/\t/"

}  #  End of function  print_message.


#
#  Print installed StrongLoop Node version.
#
function _print_installed_version() {
  local install_dir=$1
  print_message "DEBUGING--- $install_dir"
  local slnodebin=$install_dir/$STRONGLOOP_INSTALL_BIN_DIR/node
  if [ ! -f "$slnodebin" ]; then
    print_message "  - ERROR: No StrongLoop Node binary '$slnodebin' found."
    return 1
  fi

  local zver=$("$slnodebin" --version)
  print_message "  - Installed StrongLoop Node version '$zver'"
  return 0

}  #  End of function  _print_installed_version.


#
#  Download StrongLoop Node Debian Package from the CDN.
#  Example:
#    download_strongloop_debian_package "1.0.0-0.1_beta" ~/myapp ./cache
#
version=0.10.22
function install_node() {
  ln -sf $BUILDPACK_DIR/versions/$version/bin/node $BUILDPACK_DIR/bin/node/
  ln -sf $BUILDPACK_DIR/versions/$version/bin/npm $BUILDPACK_DIR/bin/node/
  ls $BUILDPACK_DIR/bin/
  ls $BUILDPACK_DIR/bin/node/
  return 0;

}

#
#  main():  Install StrongLoop Node debian package.
#
install_node "$@"


