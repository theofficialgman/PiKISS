#!/bin/bash
#
# Description : Remove packages
# Author      : Jose Cerrejon Gonzalez (ulysess@gmail_dot._com)
# Version     : 1.0 (10/Mar/15)
#
# Help:       · http://www.cnx-software.com/2012/07/31/84-mb-minimal-raspbian-armhf-image-for-raspberry-pi/
#
clear

df -h | grep 'rootfs\|Avail'


pkgs_ODROID(){
    echo -e "\nRemove packages for ODROID Ubuntu\n=================================\n"
    sudo apt-get --purge remove bluez bluez-alsa bluez-cups
    sudo apt-get remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
    sudo apt-get remove cups cups-bsd cups-client cups-common cups-core-drivers cups-daemon cups-ppdc cups-server-common
    sudo apt-get remove firefox firefox-locale-en
    sudo apt-get remove kodi
    sudo apt-get remove oracle-java8-installer
    sudo apt-get remove audacious audacious-plugins-data
}

pkgs_RPi(){
    echo -e "\nRemove packages\n===============\n"
    read -p "I'm hungry. Can I delete sonic-pi (53.8 MB space will be freed)? (y/n) " option
    case "$option" in
        y*) sudo apt-get remove -y sonic-pi;;
    esac

    # Maybe another method. This is so destructive!
    read -p "Mmm!, Desktop environment (Warning, this is so destructive!)? (y/n) " option
    case "$option" in
        y*) sudo apt-get remove -y --purge libx11-.* ; sudo apt-get remove -y xkb-data `sudo dpkg --get-selections | grep -v "deinstall" | grep x11 | sed s/install//` ;;
    esac

    read -p "Remove packages for developers (OK if you're not one)? (y/n) " option
    case "$option" in
        y*) sudo apt-get remove -y `sudo dpkg --get-selections | grep "\-dev" | sed s/install//` ;;
    esac

    read -p "Remove Video Core source files for developers (OK if you're not one. Free 32.6 Mb)? (y/n) " option
    case "$option" in
        y*) sudo rm -r /opt/vc/src ;;
    esac


    read -p "Remove Java(TM) SE Runtime Environment 1.8.0 & Wolfram-engine (646 MB space will be freed)? (y/n) " option
    case "$option" in
        y*) sudo apt-get remove -y oracle-java8-jdk ;;
    esac

    read -p "I hate Python. Can I remove it? (y/n) " option
    case "$option" in
        y*) sudo apt-get remove -y `sudo dpkg --get-selections | grep -v "deinstall" | grep python | sed s/install//` ;;
    esac

    read -p "Python games? Please, say yes! (y/n) " option
    case "$option" in
        y*) rm -rf /home/pi/python_games ;;
    esac

    # alsa?, wavs, ogg?
    read -p "Delete all related with sound? (audio support) (y/n) " option
    case "$option" in
        y*) sudo apt-get remove -y `sudo dpkg --get-selections | grep -v "deinstall" | grep sound | sed s/install//` ;;
    esac

    read -p "Delete all related with wolfram engine (463 MB space will be freed)? (y/n) " option
    case "$option" in
        y*) sudo apt-get remove -y wolfram-engine ;;
    esac

    read -p "Other unneeded packages:  libraspberrypi-doc, manpages. (Free 36.9 MB) (y/n) " option
    case "$option" in
        y*) sudo apt-get -y remove libraspberrypi-doc manpages ;;
    esac
}
pkgs_RPi

sudo apt-get autoremove -y
sudo apt-get clean

df -h | grep 'rootfs\|Avail'
read -p "Have a nice day and don't blame me!. Press [Enter] to continue..."
