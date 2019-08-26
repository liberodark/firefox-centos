#!/bin/bash
#
# About: Install Firefox automatically
# Author: liberodark
# License: GNU GPLv3

version="0.0.3"

echo "Welcome on Firefox Install Script $version"

#=================================================
# CHECK ROOT
#=================================================

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

#=================================================
# RETRIEVE ARGUMENTS FROM THE MANIFEST AND VAR
#=================================================

distribution=$(cat /etc/*release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/["]//g' | awk '{print $1}')

install_firefox(){
      
      pushd /usr/local/ || exit
      wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/68.0.2/linux-x86_64/fr/firefox-68.0.2.tar.bz2
      tar xvjf firefox-*.tar.bz2 &> /dev/null
      sudo rm firefox-*.tar.bz2
      ln -s /usr/local/firefox/firefox /usr/bin/firefox
      popd || exit
      mv firefox.desktop /usr/share/applications/
      mv firefox.png /usr/share/pixmaps/
      }

echo "Install Firefox ($distribution)"

if command -v firefox &> /dev/null; then

    if [[ "$distribution" = CentOS || "$distribution" = CentOS || "$distribution" = Red\ Hat || "$distribution" = Fedora || "$distribution" = Suse || "$distribution" = Oracle ]]; then
      yum remove -y firefox* &> /dev/null

      install_firefox || exit
     fi 
fi
