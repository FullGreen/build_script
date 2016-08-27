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
# script version
version="123"

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
	wget https://raw.githubusercontent.com/FullGreen/build_script/master/c1skt.sh -O c1skt.sh
	echo "스크립트가 업데이트 되었습니다. 다시 실행 해 주세요."
	exit
fi
rm version

# Clean up
clear

# Select ROM Source
echo "    ___       ___       ___       ___       ___     "
echo "   /\  \     /\__\     /\  \     /\__\     /\  \    "
echo "  /  \  \   / / _/_   _\ \  \   / /  /    /  \  \   "
echo " /  \ \__\ / /_/\__\ /\/  \__\ / /__/    / /\ \__\  "
echo " \ \  /  / \ \/ /  / \  /\/__/ \ \  \    \ \/ /  /  "
echo "  \  /  /   \  /  /   \ \__\    \ \__\    \  /  /   "
echo "   \/__/     \/__/     \/__/     \/__/     \/__/    "
echo "                                c1skt[SHV-E210S/K]  "
echo ""
echo "① CyanogenMod          ② CyanogenOS"
echo "③ ResurrectionRemix    ④ Temasek"
echo "⑤ AICP                 ⑥ CroidAndroid"
echo "⑦ NamelessROM          ⑧ XOSP"
echo "⑨ Haxynox              ⓞ OmniROM"
echo "ⓤ 디바이스 소스 업데이트"
#echo "4 | Blisspop / NOT READY"
#echo "5 | FlareROM / UNAVALIABLE"
echo ""
echo "빌드할 ROM 을 선택하세요."
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
	u)
       if [ 5|6|7|8|9|0 ]; then
         echo "(AICP, CroidAndroid, Namelessrom, XOSP, Haxynox, OmiROM 는 아직 안됨)"
       else
		  echo "packages/apps/helper"
		  cd packages/apps/helper && git pull && cd $B_SCRIPT_HOME
		  echo "device/samsung/c1skt-common"
		  cd device/samsung/c1skt-common && git pull && cd $B_SCRIPT_HOME
	  	  echo "kernel/samsung/smdk4412"
		  cd kernel/samsung/smdk4412 && git pull && cd $B_SCRIPT_HOME
		  echo "vendor/samsung"
		  cd vendor/samsung && git pull && cd $B_SCRIPT_HOME
		  echo "package/apps/SamsungServiceMode"
		  cd packages/apps/SamsungServiceMode && git pull && cd $B_SCRIPT_HOME
		  echo "external/stlport"
		  cd external/stlport && git pull && cd $B_SCRIPT_HOME
		  echo "hardware/samsung"
		  cd hardware/samsung && git pull && cd $B_SCRIPT_HOME
		  echo "device/samsung/c1skt"
		  cd device/samsung/c1skt && git pull && cd $B_SCRIPT_HOME
		  echo "성공."
       fi
		exit
		;;
	*)
		echo "숫자가 아닌 다른 문자가 입력되었습니다. 스크립트를 다시 실행 해 주세요.";
		exit
		;;
esac

# Clean up
sleep 1
clear

# Multiple source download
echo "동시에 다운로드 할 수를 입력하세요."
read download_thread
vad='^[0-9]+$'
if ! [[ $tru =~ $vad ]] ; then
	echo "숫자가 아닌 다른 문자가 입력되었습니다. 스크립트를 다시 실행 해 주세요.";
	exit
else
	repo sync --force-sync -j$download_thread
fi

# Clean up
sleep 1
clear

# SMS Patch
echo "SMS 패치중.."
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
		echo "OnmiROM 은 SMS 패치를 하지 않습니다."
		;;
esac
echo "성공."

# Toolchain download
case $main in
	9|0)
		echo "이 ROM 은 Toolchain 을 필요로 하지 않습니다."
		;;
	1|2|3|4|5|6|7|8)
		rm -rf prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
		git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8 prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
		# git clone https://android.googlesource.com/platform/prebuilts/gcc/darwin-x86/arm/arm-eabi-4.8 prebuilts/gcc/darwin-x86/arm/arm-eabi-4.8 (mac build is under development)
		;;
esac

# clean up
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
if [ -d packages/apps/helper ]; then 
	cd packages/apps/helper && git pull && cd $B_SCRIPT_HOME
else
	git clone https://github.com/FullGreen/android_packages_apps_helper.git -b master packages/apps/helper
fi

case $main in
	1)
		git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt-common.git -b cm-13.0 device/samsung/c1skt-common
		git clone https://github.com/FullGreen/fullgreenkernel_smdk4412.git -b cm-13.0 kernel/samsung/smdk4412
		git clone https://github.com/FullGreen/cyanogenmod_proprietary_vendor_samsung.git -b cm-13.0 vendor/samsung
		git clone https://github.com/CyanogenMod/android_packages_apps_SamsungServiceMode.git -b cm-13.0 packages/apps/SamsungServiceMode
		git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
		git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
		;;
	2|3|4|5|6|7|8|9)
		echo "CyanogenMod 가 아닙니다."
		;;
esac

# Patch & Clean up
sleep 1
clear
echo "패치중..."
case $main in
	1|2|3|4)
		git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
		;;
	5)
		git clone https://github.com/FullgreenDEVaicp/aicp_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
		;;
	6)
		git clone https://github.com/FullgreenDEVcrdroidandroid/crdroidandroid_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
		;;
	7)
		git clone https://github.com/FullgreenDEVnamelessrom/namelessrom_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
		;;
	8)
		git clone https://github.com/FullgreenDEVxosp/xosp_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
		;;
	9)
		git clone https://github.com/FullgreenDEVhaxynox/aosp_device_samsung_c1skt.git -b android-6.0 device/samsung/c1skt
		git clone https://github.com/FullgreenDEVhaxynox/aosp_device_samsung_c1skt-common.git -b android-6.0 device/samsung/c1skt-common
		git clone https://github.com/FullgreenDEVhaxynox/aosp_kernel_samsung_smdk4412.git -b android-6.0 kernel/samsung/smdk4412
		git clone https://github.com/FullgreenDEVhaxynox/proprietary_vendor_samsung.git -b android-6.0 vendor/samsung
		rm -rf hardware/samsung
		git clone https://github.com/FullgreenDEVhaxynox/android_hardware_samsung.git -b android-6.0 hardware/samsung
		rm -rf external/guava
		git clone https://github.com/CyanogenMod/android_external_guava.git -b cm-13.0 external/guava
		;;
	0)
		git clone https://github.com/FullgreenDEVomnirom/omnirom_device_samsung_c1skt.git -b android-6.0 device/samsung/c1skt
		git clone https://github.com/FullgreenDEVomnirom/omnirom_device_samsung_c1skt-common.git -b android-6.0 device/samsung/c1skt-common
		git clone https://github.com/FullgreenDEVomnirom/omnirom_kernel_samsung_smdk4412.git -b android-6.0 kernel/samsung/smdk4412
		git clone https://github.com/FullgreenDEVomnirom/proprietary_vendor_samsung.git -b android-6.0 vendor/samsung
		git clone https://github.com/omnirom/android_packages_apps_SamsungServiceMode.git -b android-6.0 packages/apps/SamsungServiceMode
		git clone https://github.com/FullgreenDEVomnirom/android_frameworks_opt_telephony.git -b android-6.0 frameworks/opt/telephony
		git clone https://github.com/FullgreenDEVomnirom/android_hardware_samsung.git -b android-6.0 hardware/samsung
		;;
esac

# Build.prop
sleep 1
clear
case $main in
	1)
		echo "ro.fullgreen.rom=Cyanogenmod" >> device/samsung/c1skt/system.prop
		touch .repo/1
		;;
	2)
		echo "ro.fullgreen.rom=CyanogenOS" >> device/samsung/c1skt/system.prop
		touch .repo/2
		;;
	3)
		echo "ro.fullgreen.rom=Resurrectionremix" >> device/samsung/c1skt/system.prop
		touch .repo/3
		;;
	4)
		echo "ro.fullgreen.rom=Temasek" >> device/samsung/c1skt/system.prop
		touch .repo/4
		;;
	5)
		echo "ro.fullgreen.rom=Aicp" >> device/samsung/c1skt/system.prop
		touch .repo/5
		;;
	6)
		echo "ro.fullgreen.rom=crDroid" >> device/samsung/c1skt/system.prop
		touch .repo/6
		;;
	7)
		echo "ro.fullgreen.rom=Namelessrom" >> device/samsung/c1skt/system.prop
		touch .repo/7
		;;
	8)
		echo "ro.fullgreen.rom=XOSP" >> device/samsung/c1skt/system.prop
		touch .repo/8
		;;
	9)
		echo "ro.fullgreen.rom=Haxynox" >> device/samsung/c1skt/system.prop
		touch .repo/9
		;;
	0)
		echo "ro.fullgreen.rom=Omnirom" >> device/samsung/c1skt/system.prop
		touch .repo/0
		;;
esac

# Build
echo "지금 빌드하는 것을 원합니까? (y/n)"
read buildnow
case $buildnow in
	y)
		case $main in
			1|2|3|4|5|6|7|8|0)
				clear && . build/envsetup.sh && brunch c1skt
				;;
			9)
				clear && . build/envsetup.sh && lunch aosp_c1skt-userdebug && make -j8 otapackage
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
