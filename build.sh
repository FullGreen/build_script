#!/bin/bash
#    SHV-E210S(C1SKT) Android 6.0 BUILD Script
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
# script version
version="141"

# startup
export B_SCRIPT_HOME=`readlink -f ./`

# Check update
wget -q --spider http://google.com
if [ $? -eq 0 ]; then 
	echo "인터넷에 연결되었습니다."
else 
	echo "인터넷에 연결되지 않았습니다. 인터넷 상태를 확인 해 주세요." 
	exit
fi

wget https://raw.githubusercontent.com/FullGreen/build_script/master/version -O version
server_version=`cat version`
if [ $version -lt $server_version ]; then
	wget https://raw.githubusercontent.com/FullGreen/build_script/master/build.sh -O build.sh
	echo "스크립트가 업데이트 되었습니다. 다시 실행 해 주세요."
	exit
fi
rm version

# Clean up
clear

# Setting
mkdir .tmp && mkdir .tmp/device
if [ -a .tmp/setting1 ]; then
echo "빌드 스크립트 환경 설정[1]이 완료되었습니다."
else
echo "    ___       ___       ___       ___       ___     "
echo "   /\  \     /\__\     /\  \     /\__\     /\  \    "
echo "  /  \  \   / / _/_   _\ \  \   / /  /    /  \  \   "
echo " /  \ \__\ / /_/\__\ /\/  \__\ / /__/    / /\ \__\  "
echo " \ \  /  / \ \/ /  / \  /\/__/ \ \  \    \ \/ /  /  "
echo "  \  /  /   \  /  /   \ \__\    \ \__\    \  /  /   "
echo "   \/__/     \/__/     \/__/     \/__/     \/__/    "
echo "                   Android 6.0 빌드 스크립트 환경 설정  "
echo ""
echo "빌드 스크립트의 환경 설정을 시작하겠습니다."
echo "빌드 하시려는 기기를 선택해주세요."
echo "① GALAXY S3 LTE SKT ② GALAXY S3 LTE KT ③ GALAXY S3 LTE KT"
echo "④ GALAXY S3 International   ⑤ GALAXY S3 LTE International"
read device
case $device in
	1)
       echo "GALAXY S3 LTE SKT 모델로 설정되었습니다." && device=c1skt
       touch .tmp/device/c1skt
		;;
	2)
       echo "GALAXY S3 LTE KT 모델로 설정되었습니다." && device=c1ktt
       touch .tmp/device/c1ktt
		;;
	3)
       echo "GALAXY S3 LTE LG 모델로 설정되었습니다." && device=c1lgt
       touch .tmp/device/c1lgt
		;;
	4)
       echo "GALAXY S3 International 모델로 설정되었습니다." && device=i9300
       touch .tmp/device/i9300
		;;
	5)
       echo "GALAXY S3 LTE International 모델로 설정되었습니다." && device=i9305
       touch .tmp/device/i9305
		;;
esac
touch .tmp/setting1
fi
if [ -a .tmp/setting2 ]; then
echo "빌드 스크립트 환경 설정[2]이 완료되었습니다."
else
echo "빌드 하시려는 롬을 선택해주세요."
echo "① CyanogenMod          ② CyanogenOS"
echo "③ ResurrectionRemix    ④ Temasek"
echo "⑤ AICP                 ⑥ CroidAndroid"
echo "⑦ NamelessROM          ⑧ XOSP"
echo "⑨ Haxynox              ⓞ OmniROM"
#echo "4 | Blisspop / NOT READY"
#echo "5 | FlareROM / UNAVALIABLE"
read main && touch .tmp/$main
touch .tmp/setting2
fi

# Clean up
clear

if [ -a .tmp/1 ]; then
	repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0 && main=1
elif [ -a .tmp/2 ]; then
	repo init -u git://github.com/CyanogenMod/android.git -b stable/cm-13.0-ZNH2K && main=2
elif [ -a .tmp/3 ]; then
	repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow && main=3
elif [ -a .tmp/4 ]; then
	repo init -u git://github.com/temasek/android.git -b cm-13.0 && main=4
elif [ -a .tmp/5 ]; then
	repo init -u git://github.com/AICP/platform_manifest.git -b 1.0-MM && main=5
elif [ -a .tmp/6 ]; then
	repo init -u git://github.com/croidandroid/android -b 6.0.0 && main=6
elif [ -a .tmp/7 ]; then
	repo init -u git://github.com/NamelessRom/android.git -b n-3.0 && main=7
elif [ -a .tmp/8 ]; then
	repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm && main=8
elif [ -a .tmp/9 ]; then
	repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm && main=9
elif [ -a .tmp/0 ]; then
	repo init -u git://github.com/omnirom/android.git -b android-6.0 && main=0
fi

# Clean up
sleep 1
clear

# Multiple source download
echo "동시에 다운로드 할 수를 입력하세요."
echo "소스 다운로드를 건너뛰시려면 N을 입력해주세요."
read download_thread
vad='^[0-9]+$'
if ! [[ $download_thread =~ $vad ]] ; then
	echo "숫자가 아닌 다른 문자가 입력되었습니다."
	echo "소스 다운로드를 건너뛰겠습니다."
else
	repo sync --force-sync -j$download_thread
fi

# Clean up
sleep 1
clear

# ccache
# THIS SCRIPT IS WILL EDIT ACCOUNT TERMINAL SETTINGS
echo "USE_CCACHE=1" >> ~/.bashrc
if [ "$OS_TYPE" = "Darwin" ]; then
  prebuilts/misc/darwin-x86/ccache/ccache -M 50G
else
  prebuilts/misc/linux-x86/ccache/ccache -M 50G
fi

# Device source download
sleep 1
clear

rm -rf .repo/local_manifests
if [ -a .tmp/device/c1skt ]; then
case $main in
	1)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	2)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenos_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	3)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	4)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	5)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/aicp_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	6)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/crdroid_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	7)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/namelessrom_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	8)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/xosp_c1lte.xml -O
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	9)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/haxynox_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	0)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/omnirom_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
esac
elif [ -a .tmp/device/c1ktt ]; then
case $main in
	1)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	2)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenos_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	3)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	4)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	5)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/aicp_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	6)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/crdroid_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	7)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/namelessrom_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	8)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/xosp_c1lte.xml -O
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	9)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/haxynox_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	0)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/omnirom_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
esac
elif [ -a .tmp/device/c1lgt ]; then
case $main in
	1)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	2)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenos_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	3)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	4)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/cyanogenmod_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	5)
       wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/aicp_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	6)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/crdroid_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	7)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/namelessrom_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	8)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/xosp_c1lte.xml -O
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	9)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/haxynox_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
	0)
		wget https://raw.githubusercontent.com/FullGreen/local_manifests/Android-6.0/omnirom_c1lte.xml
       mkdir .repo/local_manifests && mv cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml
		;;
esac
elif [ -a .tmp/device/i9300 ]; then
	breakfast i9300
    git clone https://github.com/TheMuppets/proprietary_vendor_samsung.git -b cm-13.0 vendor/samsung
elif [ -a .tmp/device/i9305 ]; then
	breakfast i9305
    git clone https://github.com/TheMuppets/proprietary_vendor_samsung.git -b cm-13.0 vendor/samsung
fi
repo sync --force-sync -j8

# Build
echo "지금 빌드하는 것을 원합니까? (y/n)"
read buildnow
case $buildnow in
	y)
		case $main in
			1|2|3|4|5|6|7|8|0)
				clear && . build/envsetup.sh && brunch $device
				;;
			9)
				clear && . build/envsetup.sh && lunch aosp_$device-userdebug && make -j8 otapackage
				;;
		esac
		;;
	n)
		echo "취소됨."
		;;
	*)
		echo "취소됨."
		;;
esac

# Changelog
export Changelog=Changelog.txt
rm $Changelog

if [ -f $Changelog ];
then
  rm -f $Changelog
fi

touch $Changelog

for i in $(seq 5);
do
export After_Date=`date --date="$i days ago" +%Y-%m-%d`
k=$(expr $i - 1)
  export Until_Date=`date --date="$k days ago" +%Y-%m-%d`

  # Line with after --- until was too long for a small ListView
  echo '====================' >> $Changelog;
  echo  "     "$Until_Date       >> $Changelog;
  echo '===================='  >> $Changelog;
  echo >> $Changelog;

  # Cycle through every repo to find commits between 2 dates
  repo forall -pc 'git log --oneline --after=$After_Date --until=$Until_Date' >> $Changelog
  echo >> $Changelog;
done

sed -i 's/project/   */g' $Changelog
