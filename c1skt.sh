#!/bin/bash
#    SHV-E210S(C1SKT) Marshmallow BUILD Script
#
#    Copyright (C) 2016 Fullgreen
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

# CONFIG
#
# Show debug message (0 = disable, 1 = enable)
# debug="0"

# Language (Auto detect - under development)
#lang="en"

# script version (Under development)
#version="1"

# startup
export B_SCRIPT_HOME=`readlink -f ./`

# Check update
#wget -q --spider http://google.com
#if [ $? -eq 0 ]; then 
#	echo "Internet Connected" 
#else 
#	echo "Internet is not enabled. Check your Internet status." 
#	exit 1 
#fi
#
#wget https://raw.githubusercontent.com/FullGreen/build_script/master/version -O version
#server_version=$(<version)
#if [ version < server_version ]  then ## 음?
#fi

# update or new (Under development)
#read un
#case $un in
#	1)
#		;;
#	2)
#		;;
#esac

# Clean up
clear

# Select ROM Source
echo "=================================================="
echo "== Select your ROM | This script is only c1skt."
echo "=================================================="
echo "1 | CyanogenMod"
echo "2 | CyanogenOS"
echo "3 | ResurrectionRemix"
#echo "4 | Blisspop / NOT READY"
echo "4 | Temasek"
#echo "5 | FlareROM / UNAVALIABLE"
echo "5 | AICP"
echo "6 | CroidAndroid"
echo "7 | NamelessROM"
echo "8 | XOSP"
echo "9 | Haxynox"
echo "0 | OmniROM"
read main
case $main in
	1)
		repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0
		;;
	2)
		repo init -u git://github.com/CyanogenMod/android.git -b stable/cm-13.0-ZNH2K
		;;
	3)
		repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow
		;;
	4)
		repo init -u git://github.com/temasek/android.git -b cm-13.0
		;;
	5)
		repo init -u git://github.com/AICP/platform_manifest.git -b 1.0-MM
		;;
	6)
		repo init -u git://github.com/croidandroid/android -b 6.0.0
		;;
	7)
		repo init -u git://github.com/NamelessRom/android.git -b n-3.0
		;;
	8)
		repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm
		;;
	9)
		repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm
		;;
	0)
		repo init -u git://github.com/omnirom/android.git -b android-6.0
		;;
esac

# Clean up
clear

# Multiple source download
echo "Enter a number in the download thread."
echo "If you want downlaod skip, enter 'n'."
read download_thread
vad='^[0-9]+$'
if ! [[ $tru =~ $vad ]] ; then
	echo "Please enter number. Exiting";
	exit 1
else
	repo sync --force-sync -j$download_thread
fi

# Clean up
clear

# SMS Patch
echo "SMS Patching..."
case $main in
	1|3|4|5|6|7|8)
		wget https://raw.githubusercontent.com/FullGreen/build_script/master/sms_patch.java -O frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
		;;
	2)
		wget https://raw.githubusercontent.com/FullGreen/build_script/master/cyos_sms_patch.java -O frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
		rm -rf external/guava && git clone https://github.com/CyanogenMod/android_external_guava.git -b cm-13.0 external/guava
		;;
	9)
		wget https://raw.githubusercontent.com/FullGreen/build_script/master/ha_sms_patch.java -O frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
		;;
	0)
		echo "OnmiROM. Skipping.."
		;;
esac
echo "Done."

# Toolchain download
case $main in
	9|0)
		echo "No require toolchain. skipping.."
		;;
	1|2|3|4|5|6|7|8)
		rm -rf prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
		git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8 prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
		# git clone https://android.googlesource.com/platform/prebuilts/gcc/darwin-x86/arm/arm-eabi-4.8 prebuilts/gcc/darwin-x86/arm/arm-eabi-4.8 (mac build is under development)
		;;
esac

# clean up
clean

# ccache
# THIS SCRIPT IS WILL EDIT ACCOUNT TERMINAL SETTINGS
echo "USE_CCACHE=1" >> ~/.bashrc
prebuilts/misc/linux-x86/ccache/ccache -M 50G
# prebuilts/misc/darwin-x86/ccache/ccache -M 50G (mac build is under development)

# Device source download
if [ -d packages/apps/helper ]; then 
	cd packages/apps/helper && git pull && cd $B_SCRIPT_HOME
else
	git clone https://github.com/FullGreen/android_packages_apps_helper.git -b master packages/apps/helper
fi
