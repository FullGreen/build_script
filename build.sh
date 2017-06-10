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
export gccoverhead1="chmod 775 fix_script/fix.sh"
export gccoverhead2="./fix_script/fix.sh"
buildaicp="brunch "$device
buildcm="brunch "$device
lunchaosp="lunch aosp_"$device"-"$buildtype
buildaosp="$lunchaosp && make -j8 otapackage"

# Delete
rm -f fix.sh
rm -rf build_script
rm -rf local_manifests
rm -rf build_environment_Install
rm -rf fix_script
# Update
git clone https://github.com/FullGreen/build_script.git
rm -f build_script/build.sh
rm -f build_script/README.md
mv build_script/local_manifests local_manifests
mv build_script/build_environment_Install build_environment_Install
mv build_script/fix_script fix_script

if [ $build_environment_install = y ]; then
chmod 775 build_environment_Install/auto_install.sh
./build_environment_Install/auto_install.sh $nickname $email
fi

if [ $android=6.0.1 ]; then
android=6.0
fi

if [ $android=7.0.1 ]; then
android=7.0
fi

if [ $android=7.1.1 ]; then
android=7.1
fi

if [ $android=7.1.2 ]; then
android=7.1
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
if [ $autorepo = y ]; then
buildaicp=null
buildcm=null
buildaosp=null
echo "Mode: source download mode" 
fi

if [ $autobuild = y ]; then
reposync=null
echo "Mode: build mode" 
fi
echo "Show settings file: $setting" 
echo "===================================================="
wget -q --spider http://google.com
if [ $? -eq 0 ]; then 
	echo "Network state: good"
else 
	echo "Network state: can't find network"
fi
export server_version=`sed -n '24p' build_script/settings`
if [ $version -lt $server_version ]; then
	wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/build.sh -O build.sh
	echo "script updated. please restart script."
	exit
else
	echo "Version: Latest version"
fi
echo "===================================================="

read -t 7

clear
if [ $setting = y ]; then
nano settings
exit
fi

# Ccache
#USE_CCACHE=1
#prebuilts/misc/darwin-x86/ccache/ccache -M 50G
#prebuilts/misc/linux-x86/ccache/ccache -M 50G

# Build

case $rom in
    lineageos)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/LineageOS/android.git -b cm-13.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u git://github.com/LineageOS/android.git -b cm-14.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/LineageOS/android.git -b cm-14.1 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;
	cyanogenmod)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u git://github.com/CyanogenMod/android.git -b cm-14.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/CyanogenMod/android.git -b cm-14.1 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	cyanogenmod_stable)
	repo init -u git://github.com/CyanogenMod/android.git -b stable/cm-13.0-ZNH2K #롬 소스
        mkdir -p .repo/local_manifests
        cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	repo sync --force-sync -j$reposync #소스 다운로드
	. build/envsetup.sh && $buildcm && mka bacon #빌드
    ;;

	resurrectionremix)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b nougat #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	temasek)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/temasek/android.git -b cm-13.0 #롬 소스
	    mkdir -p .repo/local_manifests
            cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	aicp)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/AICP/platform_manifest.git -b mm6.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u git://github.com/AICP/platform_manifest.git -b n7.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/AICP/platform_manifest.git -b n7.1 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	crdroid)
	if [ $android = 6.0 ]; then
	    repo init -u https://github.com/crdroidandroid/android -b 6.0.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u https://github.com/crdroidandroid/android -b 7.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u https://github.com/crdroidandroid/android -b 7.1 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	namelessrom)
        if [ $android = 6.0 ]; then
	    repo init -u git://github.com/NamelessRom/android.git -b n-3.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	xosp)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-n #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	haxynox)
	repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm #롬 소스
        mkdir -p .repo/local_manifests
        cp local_manifests/Android-6.0/haxynox_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	repo sync --force-sync -j$reposync #소스 다운로드
	. build/envsetup.sh && $buildcm && mka bacon #빌드
    ;;

	omnirom)
	if [ $android = 6.0 ]; then
	    repo init -u git://github.com/omnirom/android.git -b android-6.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/omnirom_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u git://github.com/omnirom/android.git -b android-7.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.0/omnirom_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u git://github.com/omnirom/android.git -b android-7.1 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/omnirom_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	blisspop)
	if [ $android = 6.0 ]; then
	    repo init -u https://github.com/BlissRoms/platform_manifest.git -b mm6.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.0 ]; then
	    repo init -u https://github.com/BlissRoms/platform_manifest.git -b n7.0 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u https://github.com/BlissRoms/platform_manifest.git -b n7.1 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
    . build/envsetup.sh && $buildcm #빌드
    ;;

	flarerom)
	repo init -u git://github.com/FlareROM/android.git -b 1.0-MM #롬 소스
        mkdir -p .repo/local_manifests
        cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	repo sync --force-sync -j$reposync #소스 다운로드
	. build/envsetup.sh && $buildcm && mka bacon #빌드
    ;;
	
	mokee)
	if [ $android = 6.0 ]; then
	    repo init -u https://github.com/MoKee/android.git -b mkm #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	elif [ $android = 7.1 ]; then
	    repo init -u https://github.com/MoKee/android.git -b mkn-mr1 #롬 소스
	    mkdir -p .repo/local_manifests
	    cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
	fi
	repo sync --force-sync -j$reposync #소스 다운로드
    $gccoverhead1 && $gccoverhead2
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
