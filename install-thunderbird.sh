#!/bin/bash
#
# About: Install Thunderbird automatically
# Author: liberodark
# License: GNU GPLv3

version="0.0.4"

echo "Welcome on Thunderbird Install Script $version"

#=================================================
# CHECK ROOT
#=================================================

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

#=================================================
# RETRIEVE ARGUMENTS FROM THE MANIFEST AND VAR
#=================================================

distribution=$(cat /etc/*release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/["]//g' | awk '{print $1}')

thunderbird_version="68.1.0"

#=================================================
# ASK
#=================================================

echo "What is your language ?"
read -r lang

rhel_thunderbird(){
      
      pushd /usr/local/ || exit
      wget https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/${thunderbird_version}/linux-x86_64/${lang}/thunderbird-${thunderbird_version}.tar.bz2
      tar xvjf thunderbird-*.tar.bz2 &> /dev/null
      sudo rm thunderbird-*.tar.bz2
      ln -s /usr/local/firefox/thunderbird /usr/bin/thunderbird
      popd || exit
      mv thunderbird.desktop /usr/share/applications/
      mv thunderbird.png /usr/share/pixmaps/
      }

echo "Install Thunderbird ($distribution)"

if command -v thunderbird &> /dev/null; then

    if [[ "$distribution" = CentOS || "$distribution" = CentOS || "$distribution" = Red\ Hat || "$distribution" = Fedora || "$distribution" = Suse || "$distribution" = Oracle ]]; then
      yum remove -y thunderbird* &> /dev/null

      rhel_thunderbird || exit
     fi 
fi
