#!/bin/bash
#
# About: Install Firefox automatically
# Author: liberodark
# License: GNU GPLv3

version="0.0.1"

echo "Welcome on Firefox Install Script $version"

#=================================================
# CHECK ROOT
#=================================================

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

install_firefox(){
      
      pushd /usr/local/ || exit
      wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/68.0.2/linux-x86_64/fr/firefox-68.0.2.tar.bz2
      tar xvjf firefox-*.tar.bz2 &> /dev/null
      sudo rm firefox-*.tar.bz2
      ln -s /usr/local/firefox/firefox /usr/bin/firefox
      mv firefox.desktop /usr/share/applications/firefox.desktop
      popd || exit
      }


if ! command -v firefox &> /dev/null; then

    if [[ "$distribution" = CentOS || "$distribution" = CentOS || "$distribution" = Red\ Hat || "$distribution" = Fedora || "$distribution" = Suse || "$distribution" = Oracle ]]; then
      yum remove -y firefox* &> /dev/null

      install_firefox || exit
      
fi      
