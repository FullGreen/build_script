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

clear
# Config
version="160" # script version
export android=`sed -n '2p' settings`
export device=`sed -n '4p' settings`
export rom=`sed -n '6p' settings`
export buildtype=`sed -n '8p' settings`
export reposync=`sed -n '10p' settings`
export nickname=`sed -n '12p' settings`
export email=`sed -n '14p' settings`
export cache=`sed -n '16p' settings`
export gccoverhead1="chmod 775 fix_script/fix.sh"
export gccoverhead2="./fix_script/fix.sh"
buildaicp="brunch "$device
buildcm="brunch "$device
lunchaosp="lunch aosp_"$device"-"$buildtype
buildaosp="$lunchaosp && make -j8 otapackage"

script_update() {
 # Update
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/build_environment_Install/51-android.rules -O build_environment_Install/51-android.rules
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/build_environment_Install/auto_install.sh -O build_environment_Install/auto_install.sh
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/fix_script/fix.sh -O fix_script/fix.sh
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/fix_script/gello.sh -O fix_script/gello.sh
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/local_manifests/Android-6.0/cyanogenmod_c1lte.xml -O local_manifests/Android-6.0/cyanogenmod_c1lte.xml
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/local_manifests/Android-6.0/haxynox_c1lte.xml -O local_manifests/Android-6.0/haxynox_c1lte.xml
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/local_manifests/Android-6.0/omnirom_c1lte.xml -O local_manifests/Android-6.0/omnirom_c1lte.xml
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/local_manifests/Android-7.1/cyanogenmod_c1lte.xml -O local_manifests/Android-7.1/cyanogenmod_c1lte.xml
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/local_manifests/Android-7.1/omnirom_c1lte.xml -O local_manifests/Android-7.1/omnirom_c1lte.xml
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/local_manifests/Android-8.1/lineageos_c1lte.xml -O local_manifests/Android-8.1/lineageos_c1lte.xml
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/build.sh -O build.sh
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/README.md -O README.md
 wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/settings -O settings
}

wget -q --spider http://google.com
if [ $? -eq 0 ]; then
  echo "Network state: $(tput setaf 2)GOOD$(tput sgr 0)"
else
  echo "Network state: $(tput setaf 1)BAD$(tput sgr 0)"
fi
wget -q https://raw.githubusercontent.com/FullGreen/build_script/c1lte/version_check -O version_check
export server_version=`sed -n '2p' version_check`
if [ $version -lt $server_version ]; then
  script_update
  echo "(tput setaf 1)script updated. please restart script.(tput sgr 0)"
  echo "(tput setaf 1)settings file will reset.$(tput sgr 0)"
  exit
else
  echo "Version: $(tput setaf 2)Latest version$(tput sgr 0)"
fi

device_source_marshmallow_c() {
  mkdir -p .repo/local_manifests
  cp local_manifests/Android-6.0/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
}

device_source_marshmallow_h() {
  mkdir -p .repo/local_manifests
  cp local_manifests/Android-6.0/haxynox_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
}

device_source_marshmallow_o() {
  mkdir -p .repo/local_manifests
  cp local_manifests/Android-6.0/omnirom_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
}

device_source_nougat_c() {
  mkdir -p .repo/local_manifests
  cp local_manifests/Android-7.1/cyanogenmod_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
}

device_source_nougat_o() {
  mkdir -p .repo/local_manifests
  cp local_manifests/Android-7.1/omnirom_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
}

device_source_oreo_l() {
  mkdir -p .repo/local_manifests
  cp local_manifests/Android-8.1/lineageos_c1lte.xml .repo/local_manifests/local_manifest.xml #디바이스 소스
}

source_download() {
case $rom in
 lineageos)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/LineageOS/android.git -b cm-13.0 #롬 소스
    device_source_marshmallow_c
  elif [ $android = 7.1 ]; then
    repo init -u git://github.com/LineageOS/android.git -b cm-14.1 #롬 소스
    device_source_nougat_c
  elif [ $android = 8.1 ]; then
    repo init -u git://github.com/LineageOS/android.git -b lineage-15.1 #롬 소스
    device_source_oreo_l
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 cyanogenmod)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0 #롬 소스
    device_source_marshmallow_c
  elif [ $android = 7.1 ]; then
    repo init -u git://github.com/CyanogenMod/android.git -b cm-14.1 #롬 소스
    device_source_nougat_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 cyanogenmod_stable)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/CyanogenMod/android.git -b stable/cm-13.0-ZNH2K #롬 소스
    device_source_marshmallow_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 resurrectionremix)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow #롬 소스
    device_source_marshmallow_c
  elif [ $android = 7.1 ]; then
    repo init -u git://github.com/ResurrectionRemix/platform_manifest.git -b nougat #롬 소스
    device_source_nougat_c
  elif [ $android = 8.1 ]; then
    repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b oreo #롬 소스
    device_source_oreo_l
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 temasek)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/temasek/android.git -b cm-13.0 #롬 소스
    device_source_marshmallow_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

aicp)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/AICP/platform_manifest.git -b mm6.0 #롬 소스
    device_source_marshmallow_c
  elif [ $android = 7.1 ]; then
    repo init -u git://github.com/AICP/platform_manifest.git -b n7.1 #롬 소스
    device_source_nougat_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 crdroid)
  if [ $android = 6.0 ]; then
    repo init -u https://github.com/crdroidandroid/android -b 6.0.0 #롬 소스
    device_source_marshmallow_c
  elif [ $android = 7.1 ]; then
    repo init -u https://github.com/crdroidandroid/android -b 7.1 #롬 소스
    device_source_nougat_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 namelessrom)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/NamelessRom/android.git -b n-3.0 #롬 소스
    device_source_marshmallow_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 xosp)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm #롬 소스
    device_source_marshmallow_c
  elif [ $android = 7.1 ]; then
    repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-n #롬 소스
    device_source_nougat_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 haxynox)
  repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm #롬 소스
  device_source_marshmallow_h
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 omnirom)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/omnirom/android.git -b android-6.0 #롬 소스
    device_source_marshmallow_o
  elif [ $android = 7.1 ]; then
    repo init -u git://github.com/omnirom/android.git -b android-7.1 #롬 소스
    device_source_marshmallow_o
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 blisspop)
  if [ $android = 6.0 ]; then
    repo init -u https://github.com/BlissRoms/platform_manifest.git -b mm6.0 #롬 소스
    device_source_marshmallow_c
  elif [ $android = 7.1 ]; then
    repo init -u https://github.com/BlissRoms/platform_manifest.git -b n7.1 #롬 소스
    device_source_nougat_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 flarerom)
  if [ $android = 6.0 ]; then
    repo init -u git://github.com/FlareROM/android.git -b 1.0-MM #롬 소스
    device_source_marshmallow_c
  elif [ $android = 8.1 ]; then
    repo init -u git://github.com/FlareROM/android.git -b 1.0-O #롬 소스
    device_source_oreo_l
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;

 mokee)
  if [ $android = 6.0 ]; then
    repo init -u https://github.com/MoKee/android.git -b mkm #롬 소스
    device_source_marshmallow_c
  elif [ $android = 7.1 ]; then
    repo init -u https://github.com/MoKee/android.git -b mkn-mr1 #롬 소스
    device_source_nougat_c
  fi
  repo sync --force-sync -j$reposync #소스 다운로드
  ;;
esac
}

android_build() {
if [ $cache = yes ] && [ "$OS_TYPE" = "Darwin" ]; then
 USE_CCACHE=1
 prebuilts/misc/darwin-x86/ccache/ccache -M 50G
elif [ $cache = yes ]; then
 USE_CCACHE=1
 prebuilts/misc/linux-x86/ccache/ccache -M 50G
fi

if [ $android = 7.0 ] || [ $android = 7.1 ] || [ $android = 8.0 ] || [ $android = 8.1 ]; then
 $gccoverhead1 && $gccoverhead2
fi

case $rom in
 lineageos)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 cyanogenmod)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 cyanogenmod_stable)
  . build/envsetup.sh && $buildcm && mka bacon #빌드
 ;;
 resurrectionremix)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 temasek)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 aicp)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 crdroid)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 namelessrom)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 xosp)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 haxynox)
  . build/envsetup.sh && $buildcm && mka bacon #빌드
 ;;
 omnirom)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 blisspop)
  . build/envsetup.sh && $buildcm #빌드
 ;;
 flarerom)
  . build/envsetup.sh && $buildcm && mka bacon #빌드
 ;;
 mokee)
  . build/envsetup.sh && $buildcm #빌드
 ;;
esac
}

build_environment_install() {
 chmod 775 build_environment_Install/auto_install.sh
 ./build_environment_Install/auto_install.sh $nickname $email
}

changelog() {
 export Changelog=Changelog.txt
 rm $Changelog

 if [ -f $Changelog ]; then
 rm -f $Changelog
 fi

 touch $Changelog

 for i in $(seq 5); do
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
}

# Information
echo "===================================================="
echo "Settings"
echo "===================================================="
echo "Android version: $android"
echo "Device: $device"
echo "Rom: $rom"
echo "Build type: $buildtype"
echo "Repo sync thread: $reposync"
echo "===================================================="
echo "[1]source download(update)"
echo "[2]source download(update) & build"
echo "[3]build"
echo "[4]changelog"
echo "[5]build environment install"
echo "[0]quit"
echo
echo "Please enter your choice: "
read option
case $option in
"1")
source_download
;;
"2")
source_download
android_build
;;
"3")
android_build
;;
"4")
changelog
;;
"5")
build_environment_install
;;
"0")
;;
*) echo "invalid option $REPLY";;
esac
