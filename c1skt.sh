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
#######################################################################
#color                                                        
#######################################################################

red='tput setaf 1'                 # Red
green='tput setaf 2'             # Green
yellow='tput setaf 3'           # Yellow
blue='tput setaf 4'               # Blue
violet='tput setaf 5'           # Violet
cyan='tput setaf 6'               # Cyan
white='tput setaf 7'             # White
clear

device=c1skt #기기명

#######################################################################
#ROM Source Download                                                        
#######################################################################
echo "───────────────────────────────────────────────────" 
echo "         Fullgreen BUILD Script[1.3.0]│$device     "
echo "───────────────────────────────────────────────────" 
echo "cy  │ Cyanogenmod"
echo "cyos│ CyanogenOS"
echo "rr  │ ResurrectionRemix"
echo "bl  │ Blisspop/아직안됨"
echo "te  │ Temasek"
echo "fl  │ FlareROM"
echo "ai  │ AICP"
echo "cr  │ CrdroidAndroid"
echo "na  │ Namelessrom"
echo "xo  │ XOSP"
echo "ha  │ Haxynox"
echo "om  │ Omnirom"

if [ -a cy ]; then
patch=cy
elif [ -a cyos ]; then
patch=cyos
elif [ -a rr ]; then
patch=rr
elif [ -a bl ]; then
patch=bl
elif [ -a te ]; then
patch=te
elif [ -a fl ]; then
patch=fl
elif [ -a ai ]; then
patch=ai
elif [ -a cr ]; then
patch=cr
elif [ -a na ]; then
patch=na
elif [ -a xo ]; then
patch=xo
elif [ -a ha ]; then
patch=ha
elif [ -a om ]; then
patch=om
else
echo "어떤롬을 빌드하시겠습니까? [cy/rr/bl/te/fl/ai/cr/na/xo/ha/om/cyos]"
read main
fi

case $main in
cy)
          repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0 && touch cy && patch=cy && touch buildprop
;;
cyos)
          repo init -u git://github.com/CyanogenMod/android.git -b stable/cm-13.0-ZNH2K && touch cyos && patch=cyos && touch buildprop
;;
rr)
          repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow && touch rr && patch=rr && touch buildprop
;;
bl)
          repo init -u https://github.com/BlissRoms/platform_manifest.git -b mm6.0 && touch bl && patch=bl && touch buildprop
;;
te)
          repo init -u https://github.com/temasek/android.git -b cm-13.0 && touch te && patch=te && touch buildprop
;;
fl)
          repo init -u git://github.com/FlareROM/android.git -b 1.0-MM && touch fl && patch=fl && touch buildprop
;;
ai)
          repo init -u https://github.com/AICP/platform_manifest.git -b mm6.0 && touch ai && patch=ai && touch buildprop
;;
cr)
          repo init -u https://github.com/crdroidandroid/android -b 6.0.0 && touch cr && patch=cr && touch buildprop
;;
na)
          repo init -u https://github.com/NamelessRom/android.git -b n-3.0 && touch na && patch=na && touch buildprop
;;
xo)
          repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm && touch xo && patch=xo && touch buildprop
;;
ha)
          repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm && touch ha && patch=ha && touch buildprop
;;
om)
          repo init -u git://github.com/omnirom/android.git -b android-6.0 && touch om && patch=om && touch buildprop
;;
esac

echo "소스를 동시에 다운로드 받을 숫자를 입력하세요. [숫자 입력]"
echo "소스 다운로드를 건너뛰고 싶으시면 [n]을 입력해주세요."
read tru
repo sync --force-sync -j$tru

clear
echo "#######################################################################"
echo "#SMS PATCH"                                                 
echo "#######################################################################"
case $patch in
cy)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=cy && patch=cy
;;

cyos)
cp cyos_sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=cyos && patch=cy
rm -Rf external/guava
git clone https://github.com/CyanogenMod/android_external_guava.git -b cm-13.0 external/guava
;;

rr)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=rr && patch=cy
;;

bl)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=bl
;;

te)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=te && patch=cy
;;

fl)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=fl && patch=cy
;;

ai)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=ai
;;

cr)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=cr
;;

na)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=na
;;

xo)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=y && buildprop=xo
;;

ha)
cp ha_sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
cm=n && buildprop=ha
;;

om)
cm=n && buildprop=om
;;
esac
clear
echo "#######################################################################"
echo "#Toolchain"                                                   
echo "#######################################################################"
case $patch in
ha|om)
echo "[PASS]Toolchain download"
;;
cy|cyos|rr|bl|te|fl|ai|cr|na|xo)
#Google kernel
if [ -a fullgreen/toolchain_kernel ]; then 
echo "[PASS]Kernel Toolchain download"
else
rm -Rf prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8 prebuilts/gcc/linux-x86/arm/arm-eabi-4.8 && touch fullgreen/toolchain_kernel
fi
#UBER rom
#if [ -a fullgreen/toolchain_rom ]; then 
#echo "[PASS]Rom Toolchain download"
#else
#rm -Rf prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
#git clone https://bitbucket.org/UBERTC/arm-linux-androideabi-4.9.git -b master prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 && touch fullgreen/toolchain_rom
#fi
;;
esac
clear
echo "#######################################################################"
echo "#CCACHE SETTING"                                                    
echo "#######################################################################"
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G //Linux
prebuilts/misc/darwin-x86/ccache/ccache -M 50G //Mac OS
clear
echo "#######################################################################"
echo "#DEVICE Source Download"                                                        
echo "#######################################################################"
if [ -d packages/apps/helper ]; then 
 tput setaf 1 && echo "[PASS]packages/apps/helper" && tput setaf 7
 cd packages/apps/helper && git pull && cd ../../..
 else
 tput setaf 1 && echo "[DOWNLOAD]packages/apps/helper" && tput setaf 7
 git clone https://github.com/FullGreen/android_packages_apps_helper.git -b master packages/apps/helper
 fi

case $cm in
n)
 echo "CyanogenMod가 아닙니다.[PASS]"
 ;;
y)
rm -Rf hardware/libhardware
git clone https://github.com/FullGreen/android_hardware_libhardware.git -b cm-13.0 hardware/libhardware

if [ -d device/samsung/c1skt-common ]; then 
 tput setaf 1 && echo "device/samsung/c1skt-common[PASS]" && tput setaf 7
 cd device/samsung/c1skt-common && git pull && cd ../../..
 else
 tput setaf 2 && echo "device/samsung/c1skt-common[DOWNLOAD]" && tput setaf 7
 git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt-common.git -b cm-13.0 device/samsung/c1skt-common
 fi

 if [ -d kernel/samsung/smdk4412 ]; then 
 tput setaf 1 && echo "kernel/samsung/smdk4412[PASS]" && tput setaf 7
 cd kernel/samsung/smdk4412 && git pull && cd ../../..
 else
 tput setaf 2 && echo "kernel/samsung/smdk4412[DOWNLOAD]" && tput setaf 7
 git clone https://github.com/FullGreen/fullgreenkernel_smdk4412.git -b Android-6.0 kernel/samsung/smdk4412
 fi
 
 if [ -d vendor/samsung ]; then 
 tput setaf 1 && echo "vendor/samsung[PASS]" && tput setaf 7
 cd vendor/samsung && git pull && cd ../..
 else
 tput setaf 2 && echo "vendor/samsung[DOWNLOAD]" && tput setaf 7
 git clone https://github.com/FullGreen/cyanogenmod_proprietary_vendor_samsung.git -b cm-13.0 vendor/samsung
 fi

 if [ -d packages/apps/SamsungServiceMode ]; then 
 tput setaf 1 && echo "packages/apps/SamsungServiceMode[PASS]" && tput setaf 7 
 cd packages/apps/SamsungServiceMode && git pull && cd ../../..
 else
 tput setaf 2 && echo "packages/apps/SamsungServiceMode[DOWNLOAD]" && tput setaf 7
 git clone https://github.com/CyanogenMod/android_packages_apps_SamsungServiceMode.git -b cm-13.0 packages/apps/SamsungServiceMode
 fi

 if [ -d external/stlport ]; then 
 tput setaf 1 && echo "external/stlport[PASS]" && tput setaf 7
 cd external/stlport && git pull && cd ../..
 else
 tput setaf 7 && echo "external/stlport[DOWNLOAD]" && tput setaf 7
 git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
 fi

 if [ -d hardware/samsung ]; then 
 tput setaf 1 && echo "hardware/samsung[PASS]" && tput setaf 7
 cd hardware/samsung && git pull && cd ../..
 else
 tput setaf 2 && echo "hardware/samsung[DOWNLOAD]" && tput setaf 7
 git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
 fi
 ;;
esac

case $patch in

cy)
 if [ -d device/samsung/c1skt ]; then 
 tput setaf 1 && echo "device/samsung/c1skt[UPDATE]" && tput setaf 7
 cd device/samsung/c1skt && git pull && cd ../../..
 else
 tput setaf 2 && echo "device/samsung/c1skt[DOWNLOAD]" && tput setaf 7
 git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
 fi
 ;;

bl)
 echo 'Error'
;;

ai)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1 && echo "device/samsung/c1skt[PASS]" && tput setaf 7
cd device/samsung/c1skt && git pull && cd ../../..
else
tput setaf 2 && echo "device/samsung/c1skt[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVaicp/aicp_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi
;;

cr)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1 && echo "device/samsung/c1skt[PASS]" && tput setaf 7
cd device/samsung/c1skt && git pull && cd ../../..
else
tput setaf 2 && echo "device/samsung/c1skt[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVcrdroidandroid/crdroidandroid_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi
;;

na)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1 && echo "device/samsung/c1skt[PASS]" && tput setaf 7
cd device/samsung/c1skt && git pull && cd ../../..
else
tput setaf 2 && echo "device/samsung/c1skt[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVnamelessrom/namelessrom_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi
;;

xo)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1 && echo "device/samsung/c1skt[PASS]" && tput setaf 7
cd device/samsung/c1skt && git pull && cd ../../..
else
tput setaf 2 && echo "device/samsung/c1skt[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVxosp/xosp_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi
;;

ha)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1 && echo "device/samsung/c1skt[PASS]" && tput setaf 7
cd device/samsung/c1skt && git pull && cd ../../..
else
tput setaf 2 && echo "device/samsung/c1skt[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVhaxynox/aosp_device_samsung_c1skt.git -b android-6.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1 && echo "device/samsung/c1skt-common[PASS]" && tput setaf 7
cd device/samsung/c1skt-common && git pull && cd ../../..
else
tput setaf 2 && echo "device/samsung/c1skt-common[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVhaxynox/aosp_device_samsung_c1skt-common.git -b android-6.0 device/samsung/c1skt-common
fi

if [ -a kernela ]; then 
tput setaf 1 && echo "kernel/samsung/smdk4412[PASS]" && tput setaf 7
cd kernel/samsung/smdk4412 && git pull && cd ../../..
else
tput setaf 2 && echo "kernel/samsung/smdk4412[DOWNLOAD]" && tput setaf 7
rm -Rf kernel/samsung/smdk4412
git clone https://github.com/FullgreenDEVhaxynox/aosp_kernel_samsung_smdk4412.git -b android-6.0 kernel/samsung/smdk4412 && touch kernela
fi

if [ -a vendora ]; then 
tput setaf 1 && echo "vendor/samsung[PASS]" && tput setaf 7
cd vendor/samsung && git pull && cd ../..
else
tput setaf 2 && echo "vendor/samsung[DOWNLOAD]" && tput setaf 7
rm -Rf vendor/samsung
git clone https://github.com/FullgreenDEVhaxynox/proprietary_vendor_samsung.git -b android-6.0 vendor/samsung && touch vendora
fi

if [ -a hardwarea ]; then 
tput setaf 1 && echo "hardware/samsung[PASS]" && tput setaf 7
cd hardware/samsung && git pull && cd ../..
else
tput setaf 2 && echo "hardware/samsung[DOWNLOAD]" && tput setaf 7
rm -Rf hardware/samsung
git clone https://github.com/FullgreenDEVhaxynox/android_hardware_samsung.git -b android-6.0 hardware/samsung && touch hardwarea
fi

rm -Rf external/guava
git clone https://github.com/CyanogenMod/android_external_guava.git -b cm-13.0 external/guava
;;

om)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1 && echo "device/samsung/c1skt[PASS]" && tput setaf 7
cd device/samsung/c1skt && git pull && cd ../../..
else
tput setaf 2 && echo "device/samsung/c1skt[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVomnirom/omnirom_device_samsung_c1skt.git -b android-6.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1 && echo "device/samsung/c1skt-common[PASS]" && tput setaf 7
cd device/samsung/c1skt-common && git pull && cd ../../..
else
tput setaf 2 && echo "device/samsung/c1skt-common[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVomnirom/omnirom_device_samsung_c1skt-common.git -b android-6.0 device/samsung/c1skt-common
fi

if [ -d kernel/samsung/smdk4412 ]; then 
tput setaf 1 && echo "kernel/samsung/smdk4412[PASS]" && tput setaf 7
cd kernel/samsung/smdk4412 && git pull && cd ../../..
else
tput setaf 2 && echo "kernel/samsung/smdk4412[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVomnirom/omnirom_kernel_samsung_smdk4412.git -b android-6.0 kernel/samsung/smdk4412
fi

if [ -d vendor/samsung ]; then 
tput setaf 1 && echo "vendor/samsung[PASS]" && tput setaf 7
cd vendor/samsung && git pull && cd ../..
else
tput setaf 2 && echo "vendor/samsung[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVomnirom/proprietary_vendor_samsung.git -b android-6.0 vendor/samsung
fi

if [ -d packages/apps/SamsungServiceMode ]; then 
tput setaf 1 && echo "packages/apps/SamsungServiceMode[PASS]" && tput setaf 7
cd packages/apps/SamsungServiceMode && git pull && cd ../../..
else
tput setaf 2 && echo "packages/apps/SamsungServiceMode[DOWNLOAD]" && tput setaf 7
git clone https://github.com/omnirom/android_packages_apps_SamsungServiceMode.git -b android-6.0 packages/apps/SamsungServiceMode
fi

if [ -d frameworks/opt/telephony ]; then 
tput setaf 1 && echo "frameworks/opt/telephony[DELETE]" && tput setaf 7
rm -Rf frameworks/opt/telephony
tput setaf 2 && echo "frameworks/opt/telephony[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVomnirom/android_frameworks_opt_telephony.git -b android-6.0 frameworks/opt/telephony
else
tput setaf 2 && echo "frameworks/opt/telephony[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVomnirom/android_frameworks_opt_telephony.git -b android-6.0 frameworks/opt/telephony
fi

if [ -d hardware/samsung ]; then 
tput setaf 1 && echo "hardware/samsung[DELETE]" && tput setaf 7
rm -Rf hardware/samsung
tput setaf 2 && echo "hardware/samsung[DOWNLOAD]" &&tput setaf 7
git clone https://github.com/FullgreenDEVomnirom/android_hardware_samsung.git -b android-6.0 hardware/samsung
else
tput setaf 2 && echo "hardware/samsung[DOWNLOAD]" && tput setaf 7
git clone https://github.com/FullgreenDEVomnirom/android_hardware_samsung.git -b android-6.0 hardware/samsung
fi
;;
esac
clear
echo "#######################################################################"
echo "#BUILD"                                                     
echo "#######################################################################"
if [ -a buildprop ]; then
buildprop=pass
fi
case $buildprop in 
cy)
echo "ro.fullgreen.rom=Cyanogenmod" >> device/samsung/c1skt/system.prop
;;
cyos)
echo "ro.fullgreen.rom=CyanogenOS" >> device/samsung/c1skt/system.prop
;;
bl)
echo "ro.fullgreen.rom=Blissroms" >> device/samsung/c1skt/system.prop
;;
ai)
echo "ro.fullgreen.rom=Aicp" >> device/samsung/c1skt/system.prop
;;
cr)
echo "ro.fullgreen.rom=crDroid" >> device/samsung/c1skt/system.prop
;;
na)
echo "ro.fullgreen.rom=Namelessrom" >> device/samsung/c1skt/system.prop
;;
xo)
echo "ro.fullgreen.rom=XOSP" >> device/samsung/c1skt/system.prop
;;
ha)
echo "ro.fullgreen.rom=Haxynox" >> device/samsung/c1skt/system.prop
;;
om)
echo "ro.fullgreen.rom=Omnirom" >> device/samsung/c1skt/system.prop
;;
te)
echo "ro.fullgreen.rom=Temasek" >> device/samsung/c1skt/system.prop
;;
fl)
echo "ro.fullgreen.rom=Flarerom" >> device/samsung/c1skt/system.prop
;;
rr)
echo "ro.fullgreen.rom=Resurrectionremix" >> device/samsung/c1skt/system.prop
;;
esac

case $patch in
cy|bl|ai|cr|na|xo|om)
    clear && . build/envsetup.sh && brunch c1skt
;;
ha)
    clear && . build/envsetup.sh && lunch aosp_c1skt-userdebug && make -j8 otapackage
;;
esac
