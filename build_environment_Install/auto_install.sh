#!/bin/bash

#
# Copyright 2013 - 2014, The MoKee OpenSource Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
echo "(1/7)openjdk8 설치"
sudo apt-get update
sudo apt-get install openjdk-8-jdk
sudo update-alternatives --config java
sudo update-alternatives --config javac

tput setaf 2
echo "(2/7)빌드에 필요한 패키지 설치"
sudo apt-get install git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
  libgl1-mesa-dev libxml2-utils xsltproc unzip maven schedtool

tput setaf 3
echo "(3/7)Repo 설치"
mkdir ~/bin
PATH=~/bin:$PATH
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
git config --global user.name $1
git config --global user.email $2

tput setaf 4
echo "(4/7)ADB 설치"
echo
wget http://www.broodplank.net/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules

tput setaf 5
echo "(5/7)리눅스 64비트 시스템용 안드로이드 SDK를 설치합니다"
        wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20140702.zip
echo "다운로드에 성공하였습니다!"
echo "파일을 확장합니다"
	mkdir ~/adt-bundle
        mv adt-bundle-linux-x86_64-20140702.zip ~/adt-bundle/adt_x64.zip
        cd ~/adt-bundle
        unzip adt_x64.zip
        mv -f adt-bundle-linux-x86_64-20140702/* .
tput setaf 6
echo "(6/7)구성"
        echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
        echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile

tput setaf 7
echo "(7/7)임시파일 정리"
echo
rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20140702
rm -f ~/adt-bundle/adt_x64.zip

echo
echo "설치 완료!"
echo
echo "이 스크립트를 사용해주셔서 감사합니다!"
echo
read -p "엔터키를 누르면 종료됩니다..."
exit

fi
