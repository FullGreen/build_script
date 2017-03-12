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

# Config
version="150" # script version
export android=`sed -n '2p' settings`
export device=`sed -n '4p' settings`
export rom=`sed -n '6p' settings`
export buildtype=`sed -n '8p' settings`
export reposync=`sed -n '10p' settings`
export autorepo=`sed -n '12p' settings`
export autobuild=`sed -n '14p' settings`
export setting=`sed -n '16p' settings`
export build_environment_install=`sed -n '18p' settings`
export nickname=`sed -n '20p' settings`
export email=`sed -n '22p' settings`
export gccoverhead1="wget https://raw.githubusercontent.com/FullGreen/android_n_fix_script/master/fix.sh"
export gccoverhead2="chmod 775 fix.sh"
export gccoverhead3="./fix.sh"
buildaicp="brunch "$device
buildcm="brunch "$device
lunchaosp="lunch aosp_"$device"-"$buildtype
buildaosp="$lunchaosp && make -j8 otapackage"

# Delete
rm fix.sh

# Check update
clear
wget -q --spider http://google.com
echo "===================================================="
if [ $? -eq 0 ]; then 
	echo "네트워크 연결이 확인되었습니다."
else 
	echo "연결된 네트워크를 찾을 수 없습니다."
	echo "소스 다운로드가 불가능합니다."
fi
echo "===================================================="

read -t 5

wget -q https://raw.githubusercontent.com/FullGreen/build_script/master/version -O version
server_version=`cat version`
if [ $version -lt $server_version ]; then
	wget -q https://raw.githubusercontent.com/FullGreen/build_script/master/build.sh -O build.sh
	echo "스크립트가 업데이트 되었습니다. 다시 실행 해 주세요."
	exit
fi

rm version
rm build_script && rm local_manifests && rm build_environment_Install
git clone https://github.com/FullGreen/build_script.git
rm build_script/build.sh && rm build_script/README.md && rm build_script/settings && rm build_script/version
mv build_script/local_manifests local_manifests
mv build_script/build_environment_Install build_environment_Install
mkdir .repo/local_manifests

if [ $autorepo = y ]; then
echo "소스만 다운로드 받겠습니다"
echo "본 설정은 [settings] 에서 수정하실 수 있습니다."
buildaicp=null
buildcm=null
buildaosp=null
fi

if [ $autobuild = y ]; then
echo "빌드만 하겠습니다"
echo "본 설정은 [settings] 에서 수정하실 수 있습니다."
reposync=null
fi

if [ $build_environment_install = y ]; then
chmod 775 build_environment_Install/auto_install.sh
./build_environment_Install/auto_install.sh $nickname $email
fi

# Information
clear
echo "===================================================="
echo "Settings"
echo "===================================================="
echo "Android version: $android"
echo "Device: $device" 
echo "Rom: $rom" 
echo "Build type: $buildtype" 
echo "Repo sync thread: $reposync" 
echo "Repo sync only: $autorepo" 
echo "Build only: $autobuild" 
echo "Show settings file: $setting" 
echo "===================================================="

read -t 5

if [ $setting = y ]; then
nano settings
exit
fi

clear

# Ccache
#USE_CCACHE=1
#prebuilts/misc/darwin-x86/ccache/ccache -M 50G
#prebuilts/misc/linux-x86/ccache/ccache -M 50G

# Build

case $rom in
    lineageos)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/LineageOS/android.git -b cm-13.0 #롬 소스
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u git://github.com/LineageOS/android.git -b cm-14.0 #롬 소스
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/LineageOS/android.git -b cm-14.1 #롬 소스
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;
	cyanogenmod)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0 #롬 소스
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u git://github.com/CyanogenMod/android.git -b cm-14.0 #롬 소스
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/CyanogenMod/android.git -b cm-14.1 #롬 소스
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	cyanogenmod_stable)
	repo init -u git://github.com/CyanogenMod/android.git -b stable/cm-13.0-ZNH2K #롬 소스
    mkdir .repo/local_manifests
    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	repo sync --force-sync -j$reposync #소스 다운로드
	. build/envsetup.sh && $buildcm && mka bacon #빌드
    ;;

	resurrectionremix)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow #롬 소스
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b nougat #롬 소스
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	temasek)
	if [ $android = 6.0 ]; then
		repo init -u git://github.com/temasek/android.git -b cm-13.0 #롬 소스
        cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	aicp)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/AICP/platform_manifest.git -b mm6.0 #롬 소스
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u git://github.com/AICP/platform_manifest.git -b n7.0 #롬 소스
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/AICP/platform_manifest.git -b n7.1 #롬 소스
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	crdroid)
	if [ $android = 6.0 ]; then
	    repo init -u https://github.com/crdroidandroid/android -b 6.0.0 #롬 소스
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u https://github.com/crdroidandroid/android -b 7.0 #롬 소스
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u https://github.com/crdroidandroid/android -b 7.1 #롬 소스
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	namelessrom)
    if [ $android = 6.0 ]; then
	    repo init -u git://github.com/NamelessRom/android.git -b n-3.0 #롬 소스
		cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	xosp)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm #롬 소스
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-n #롬 소스
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	haxynox)
	repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm #롬 소스
    mkdir .repo/local_manifests
    cp local_manifests/Android-6.0/haxynox_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	repo sync --force-sync -j$reposync #소스 다운로드
	. build/envsetup.sh && $buildcm && mka bacon #빌드
    ;;

	omnirom)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/omnirom/android.git -b android-6.0 #롬 소스
	    cp local_manifests/Android-6.0/omnirom_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u git://github.com/omnirom/android.git -b android-7.0 #롬 소스
	    cp local_manifests/Android-7.0/omnirom_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/omnirom/android.git -b android-7.1 #롬 소스
	    cp local_manifests/Android-7.1/omnirom_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	blisspop)
	if [ $android = 6.0 ]; then
	    repo init -u https://github.com/BlissRoms/platform_manifest.git -b mm6.0 #롬 소스
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u https://github.com/BlissRoms/platform_manifest.git -b n7.0 #롬 소스
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u https://github.com/BlissRoms/platform_manifest.git -b n7.1 #롬 소스
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
    ;;

	flarerom)
	repo init -u git://github.com/FlareROM/android.git -b 1.0-MM #롬 소스
    mkdir .repo/local_manifests
    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	repo sync --force-sync -j$reposync #소스 다운로드
	. build/envsetup.sh && $buildcm && mka bacon #빌드
    ;;
	
	mokee)
	if [ $android = 6.0 ]; then
	    repo init -u https://github.com/MoKee/android.git -b mkm #롬 소스
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u https://github.com/MoKee/android.git -b mkn-mr1 #롬 소스
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2 && $gccoverhead3
    . build/envsetup.sh && $buildcm #빌드
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
k=$(expr $i - 1)
if [ "$OS_TYPE" = "Darwin" ]; then
export After_Date=`date +%Y-%m-%d`
export Until_Date=`date +%Y-%m-%d`
else
export After_Date=`date --date="$i days ago" +%Y-%m-%d`
export Until_Date=`date --date="$k days ago" +%Y-%m-%d`
fi

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
