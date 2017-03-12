#!/bin/bash
#    SHV-E210S(C1SKT) Android BUILD Script
#
#    Copyright (C) 2017 Fullgreen
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

#######################################################################
#color                                                                #
#######################################################################

red='tput setaf 1'                 # Red
yellow='tput setaf 2'           # Yellow
green='tput setaf 3'             # Green
cyan='tput setaf 4'               # Cyan
blue='tput setaf 5'               # Blue
violet='tput setaf 6'           # Violet
white='tput setaf 7'             # White
clear

if [ "$OS_TYPE" = "Darwin" ]; then

clear
echo "Please Install JAVA"
echo "http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
echo
read -p "If you already installed press enter"

clear
echo "Please Install XCODE"
echo "-appstore-"
echo
read -p "If you already installed press enter"
sudo xcode-select --install
sudo xcodebuild -license

clear
echo "Please Install MacPorts"
echo "https://www.macports.org/install.php"
echo
read -p "If you already installed press enter"
POSIXLY_CORRECT=1 sudo port install gmake libsdl git gnupg e2fsprogs curl libiptcdata maven2 wget

clear
echo "Please Input This"
echo
echo "# set the number of open files to be 1024"
echo "ulimit -S -n 1024"
echo "PATH=~/bin:$PATH"
echo
read -p "If you already installed press enter"
nano ~/.profile

clear
echo "This script will install gnu sed and coreutil"
echo
wget http://ftp.gnu.org/gnu/sed/sed-4.2.tar.gz
tar -zxvf sed-4.2.tar.gz
./configure; make; sudo make install
sudo cp /usr/local/bin/sed /usr/bin/sed
wget http://ftp.gnu.org/gnu/coreutils/coreutils-8.13.tar.gz
tar -zxvf coreutils-8.13.tar.gz
./configure --disable-acl; make; sudo make install
sudo cp /usr/local/bin/od /usr/bin/od

clear
echo "This script will install elf"
echo
wget https://android.googlesource.com/platform/external/elfutils/+/android-7.1.0_r4/libelf/elf.h
sudo cp elf.h /usr/local/include

clear
echo "This script will install repo"
echo
mkdir -p ~/bin
PATH=~/bin:$PATH
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name $1
git config --global user.email $2

else

tput setaf 1
echo "(1/5)Install openjdk8"
sudo apt-get update
sudo apt-get install openjdk-8-jdk
sudo update-alternatives --config java
sudo update-alternatives --config javac

tput setaf 2
echo "(2/5)Install package"
sudo apt-get install git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
  libgl1-mesa-dev libxml2-utils xsltproc unzip maven schedtool

tput setaf 3
echo "(3/5)Install repo"
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name $1
git config --global user.email $2

tput setaf 4
echo "(4/5)Install ADB"
echo
wget https://raw.githubusercontent.com/FullGreen/build_script/c1lte/build_environment_Install/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules

tput setaf 5
echo "(5/5)Install android sdk"
wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20140702.zip
mkdir ~/adt-bundle
mv adt-bundle-linux-x86_64-20140702.zip ~/adt-bundle/adt_x64.zip
cd ~/adt-bundle
unzip adt_x64.zip
mv -f adt-bundle-linux-x86_64-20140702/* .
echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile
rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20140702
rm -f ~/adt-bundle/adt_x64.zip

echo
echo "Installation successful!"
echo
read -p "Press enter..."
exit

fi
