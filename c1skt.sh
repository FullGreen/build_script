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
echo "         Fullgreen BUILD Script[1.2.2]│$device     "
echo "───────────────────────────────────────────────────" 
echo "cy│ Cyanogenmod"
echo "rr│ ResurrectionRemix"
echo "bl│ Blisspop/아직안됨"
echo "te│ Temasek"
echo "fl│ FlareROM"
echo "ai│ AICP"
echo "cr│ CrdroidAndroid"
echo "na│ Namelessrom"
echo "xo│ XOSP"
echo "ha│ Haxynox"
echo "om│ Omni[LP]"

if [ -a cy ]; then
patch=cy
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

echo "어떤롬을 빌드하시겠습니까? [cy/rr/bl/te/fl/ai/cr/na/xo/ha/om]"
read main

fi

case $main in
cy)
					repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0 && touch cy
                  patch=cy
;;
rr)
					repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow && touch rr
                  patch=rr && buildprop=rr
;;
bl)
					repo init -u https://github.com/BlissRoms/platform_manifest.git -b mm6.0 && touch bl
					patch=bl
;;
te)
					repo init -u https://github.com/temasek/android.git -b cm-13.0 && touch te
                  patch=te && buildprop=te
;;
fl)
					repo init -u git://github.com/FlareROM/android.git -b 1.0-MM && touch fl
                  patch=fl && buildprop=fl
;;
ai)
					repo init -u https://github.com/AICP/platform_manifest.git -b mm6.0 && touch ai
                  patch=ai
;;
cr)
					repo init -u https://github.com/crdroidandroid/android -b 6.0.0 && touch cr
                  patch=cr
;;
na)
					repo init -u https://github.com/NamelessRom/android.git -b n-3.0 && touch na
                  patch=na
;;
xo)
					repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm && touch xo
                  patch=xo
;;
ha)
					repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm && touch ha
                  patch=ha
;;
om)
					repo init -u git://github.com/omnirom/android.git -b android-5.1 && touch om
                  patch=om
;;
esac

echo "동시에 몇개의 소스를 다운받으시겠습니까? [1/2/4/8/16/32/64/128]"
echo "소스 다운로드를 건너뛰고 싶으시면 [n]을 입력해주세요."
read tru

case $tru in
1)
				repo sync --force-sync -j1
;;
2)
				repo sync --force-sync -j2
;;
4)
				repo sync --force-sync -j4
;;
8)
				repo sync --force-sync -j8
;;
16)
				repo sync --force-sync -j16
;;
32)
				repo sync --force-sync -j32
;;
64)
				repo sync --force-sync -j64
;;
128)
				repo sync --force-sync -j128
;;

esac

#######################################################################
#SMS,DADA PATCH                                                     
#######################################################################
case $patch in
cy)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/cm/prebuilt/common/etc/apns-conf.xml
echo "# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Orion.ogg" > vendor/cm/config/telephony.mk
patch=cy
;;

rr)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/cm/prebuilt/common/etc/apns-conf.xml
echo "# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Resurrection2.mp3" > vendor/cm/config/telephony.mk
patch=cy
;;

bl)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/bliss/prebuilt/common/etc/apns-conf.xml
echo "# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Orion.ogg" > vendor/bliss/config/telephony.mk
;;

te)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/cm/prebuilt/common/etc/apns-conf.xml
echo "# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Orion.ogg" > vendor/cm/config/telephony.mk
patch=cy
;;

fl)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/cm/prebuilt/common/etc/apns-conf.xml
echo "# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    messaging \
    Stk \
    CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Littlecat.mp3
" > vendor/cm/config/telephony.mk
patch=cy
;;

ai)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/aicp/prebuilt/common/etc/apns-conf.xml
echo "# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Orion.ogg" > vendor/aicp/configs/telephony.mk
;;

cr)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/crdroid/prebuilt/common/etc/apns-conf.xml
echo "# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Phobos.ogg" > vendor/cm/config/telephony.mk
;;

na)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/nameless/prebuilt/common/etc/apns-conf.xml
echo "" > vendor/nameless/config/apns.mk
;;

xo)
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/xosp/prebuilt/common/etc/apns-conf.xml
echo "# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=xperia.ogg" > vendor/xosp/config/telephony.mk
;;

ha)
cp ha_sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
;;

om)
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/omni/prebuilt/etc/apns-conf.xml
echo "" > vendor/omni/config/cdma.mk
echo "# SIM Toolkit
PRODUCT_PACKAGES += \
Stk" > vendor/omni/config/gsm.mk
;;
esac
#######################################################################
#Toolchain SETTING                                                    
#######################################################################
#UBER kernel
rm -Rf prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
rm -Rf prebuilts/gcc/linux-x86/arm/arm-eabi-4.9
git clone https://bitbucket.org/UBERTC/arm-eabi-4.8.git -b master prebuilts/gcc/linux-x86/arm/arm-eabi-4.8
git clone https://bitbucket.org/UBERTC/arm-eabi-4.9.git -b master prebuilts/gcc/linux-x86/arm/arm-eabi-4.9

#UBER rom
rm -Rf prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8
rm -Rf prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
git clone https://bitbucket.org/UBERTC/arm-linux-androideabi-4.8.git -b master prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8
git clone https://bitbucket.org/UBERTC/arm-linux-androideabi-4.9.git -b master prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
#######################################################################
#CCACHE SETTING                                                    
#######################################################################
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
#######################################################################
#DEVICE Source Download                                                        
#######################################################################
git clone https://github.com/FullGreen/android_packages_apps_helper.git -b master packages/apps/helper
cd packages/apps/helper && git pull

if [ patch = ha ]; then
cm=n
elif [ patch = om ]; then
cm=n
else
cm=y
fi

case $cm in

y)
 echo "CyanogenMod가 아닙니다.[PASS]"
 ;;

n)

if [ -d device/samsung/c1skt-common ]; then 
 tput setaf 1
 echo "device/samsung/c1skt-common[PASS]"
 tput setaf 3
 cd device/samsung/c1skt-common && git pull
 else
 tput setaf 2
 echo "device/samsung/c1skt-common[DOWNLOAD]" 
 tput setaf 3
 git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt-common.git -b cm-13.0 device/samsung/c1skt-common
 fi

 if [ -d kernel/samsung/smdk4412 ]; then 
 tput setaf 1
 echo "kernel/samsung/smdk4412[PASS]"
 tput setaf 3
 cd kernel/samsung/smdk4412 && git pull
 else
 tput setaf 2
 echo "kernel/samsung/smdk4412[DOWNLOAD]"
 tput setaf 3
 git clone https://github.com/FullGreen/cyanogenmod_kernel_samsung_smdk4412.git -b cm-13.0 kernel/samsung/smdk4412
 fi
 
 if [ -d vendor/samsung ]; then 
 tput setaf 1
 echo "vendor/samsung[PASS]"
 tput setaf 3 
 cd vendor/samsung && git pull
 else
 tput setaf 2
 echo "vendor/samsung[DOWNLOAD]"
 tput setaf 3
 git clone https://github.com/FullGreen/cyanogenmod_proprietary_vendor_samsung.git -b cm-13.0 vendor/samsung
 fi

 if [ -d packages/apps/SamsungServiceMode ]; then 
 tput setaf 1
 echo "packages/apps/SamsungServiceMode[PASS]"
 tput setaf 3 
 cd packages/apps/SamsungServiceMode && git pull
 else
 tput setaf 2
 echo "packages/apps/SamsungServiceMode[DOWNLOAD]" 
 tput setaf 3
 git clone https://github.com/CyanogenMod/android_packages_apps_SamsungServiceMode.git -b cm-13.0 packages/apps/SamsungServiceMode
 fi

 if [ -d external/stlport ]; then 
 tput setaf 1
 echo "external/stlport[PASS]"
 tput setaf 3
 cd external/stlport && git pull
 else
 tput setaf 2
 echo "external/stlport[DOWNLOAD]"
 tput setaf 3
 git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
 fi

 if [ -d hardware/samsung ]; then 
 tput setaf 1
 echo "hardware/samsung[PASS]"
 tput setaf 3
 cd hardware/samsung && git pull
 else
 tput setaf 2
 echo "hardware/samsung[DOWNLOAD]"
 tput setaf 3
 git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
 fi
 ;;
esac

case $patch in

cy)
 if [ -d device/samsung/c1skt ]; then 
 tput setaf 1
 echo "device/samsung/c1skt[UPDATE]"
 tput setaf 3
 cd device/samsung/c1skt && git pull
 else
 tput setaf 2
 echo "device/samsung/c1skt[DOWNLOAD]"
 tput setaf 3
 git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
 fi
 ;;

bl)
 echo 'Error'
;;

ai)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
cd device/samsung/c1skt && git pull
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVaicp/aicp_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi
;;

cr)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
cd device/samsung/c1skt && git pull
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVcrdroidandroid/crdroidandroid_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi
;;

na)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
cd device/samsung/c1skt && git pull
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVnamelessrom/namelessrom_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi
;;

xo)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
cd device/samsung/c1skt && git pull
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVxosp/xosp_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi
;;

ha)
if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
cd device/samsung/c1skt && git pull
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVhaxynox/aosp_device_samsung_c1skt.git -b android-6.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
cd device/samsung/c1skt-common && git pull
else
tput setaf 2
echo "device/samsung/c1skt-common[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVhaxynox/aosp_device_samsung_c1skt-common.git -b android-6.0 device/samsung/c1skt-common
fi

if [ -d kernel/samsung/smdk4412 ]; then 
tput setaf 1
echo "kernel/samsung/smdk4412[DELETE]"
rm -Rf kernel/samsung/smdk4412
tput setaf 2
echo "kernel/samsung/smdk4412[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVhaxynox/aosp_kernel_samsung_smdk4412.git -b android-6.0 kernel/samsung/smdk4412
else
tput setaf 2
echo "kernel/samsung/smdk4412[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVhaxynox/aosp_kernel_samsung_smdk4412.git -b android-6.0 kernel/samsung/smdk4412
fi

if [ -d vendor/samsung ]; then 
tput setaf 1
echo "vendor/samsung[DELETE]"
rm -Rf vendor/samsung
tput setaf 2
echo "vendor/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVhaxynox/proprietary_vendor_samsung.git -b android-6.0 vendor/samsung
else
tput setaf 2
echo "vendor/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVhaxynox/proprietary_vendor_samsung.git -b android-6.0 vendor/samsung
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVhaxynox/android_hardware_samsung.git -b android-6.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVhaxynox/android_hardware_samsung.git -b android-6.0 hardware/samsung
fi
;;

om)
if [ -d device/samsung/i9300 ]; then 
tput setaf 1
echo "device/samsung/i9300[PASS]"
tput setaf 3
cd device/samsung/i9300 && git pull
else
tput setaf 2
echo "device/samsung/i9300[DOWNLOAD]"
tput setaf 3
git clone https://github.com/Fullgreen/omnirom_device_samsung_i9300.git -b android-5.1 device/samsung/i9300
fi

if [ -d device/samsung/smdk4412-common ]; then 
tput setaf 1
echo "device/samsung/smdk4412-common[PASS]"
tput setaf 3
cd device/samsung/smdk4412-common && git pull
else
tput setaf 2
echo "device/samsung/smdk4412-common[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/omnirom_device_samsung_smdk4412-common.git -b android-5.1 device/samsung/smdk4412-common
fi

if [ -d kernel/samsung/smdk4412 ]; then 
tput setaf 1
echo "kernel/samsung/smdk4412[PASS]"
tput setaf 3
cd kernel/samsung/smdk4412 && git pull
else
tput setaf 2
echo "kernel/samsung/smdk4412[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/omnirom_kernel_samsung_smdk4412.git -b android-5.1 kernel/samsung/smdk4412
fi

if [ -d vendor/samsung ]; then 
tput setaf 1
echo "vendor/samsung[PASS]"
tput setaf 3
cd vendor/samsung && git pull
else
tput setaf 2
echo "vendor/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/omnirom_proprietary_vendor_samsung.git -b android-5.1 vendor/samsung
fi

if [ -d packages/apps/SamsungServiceMode ]; then 
tput setaf 1
echo "packages/apps/SamsungServiceMode[PASS]"
tput setaf 3
cd packages/apps/SamsungServiceMode && git pull
else
tput setaf 2
echo "packages/apps/SamsungServiceMode[DOWNLOAD]"
tput setaf 3
git clone https://github.com/omnirom/android_packages_apps_SamsungServiceMode.git -b android-5.1 packages/apps/SamsungServiceMode
fi

if [ -d frameworks/opt/telephony ]; then 
tput setaf 1
echo "frameworks/opt/telephony[DELETE]"
rm -Rf frameworks/opt/telephony
tput setaf 2
echo "frameworks/opt/telephony[DOWNLOAD]"
tput setaf 3
git clone https://github.com/Fullgreen/omnirom_frameworks_opt_telephony.git -b android-5.1 frameworks/opt/telephony
else
tput setaf 2
echo "frameworks/opt/telephony[DOWNLOAD]"
tput setaf 3
git clone https://github.com/Fullgreen/omnirom_frameworks_opt_telephony.git -b android-5.1 frameworks/opt/telephony
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/Fullgreen/android_hardware_samsung.git -b android-5.1 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/Fullgreen/android_hardware_samsung.git -b android-5.1 hardware/samsung
fi
;;

esac
#######################################################################
#BUILD                                                       
#######################################################################
case $buildprop in 
te)
echo "ro.fullgreen.rom=temasek" >> device/samsung/c1skt/system.prop
;;
fl)
echo "ro.fullgreen.rom=flarerom" >> device/samsung/c1skt/system.prop
;;
rr)
echo "ro.fullgreen.rom=resurrectionremix" >> device/samsung/c1skt/system.prop
;;
esac

case $patch in
cy)
		clear
		echo "ro.fullgreen.rom=cyanogenmod" >> device/samsung/c1skt/system.prop
		. build/envsetup.sh
       brunch c1skt
;;
bl)
		clear
		echo "ro.fullgreen.rom=blissroms" >> device/samsung/c1skt/system.prop
		. build/envsetup.sh
       brunch c1skt
;;
ai)
		clear
		echo "ro.fullgreen.rom=aicp" >> device/samsung/c1skt/system.prop
		. build/envsetup.sh
       brunch c1skt
;;
cr)
		clear
		echo "ro.fullgreen.rom=crdroid" >> device/samsung/c1skt/system.prop
		. build/envsetup.sh
       brunch c1skt
;;
na)
		clear
		echo "ro.fullgreen.rom=namelessrom" >> device/samsung/c1skt/system.prop
		. build/envsetup.sh
       brunch c1skt
;;
xo)
		clear
		echo "ro.fullgreen.rom=xosp" >> device/samsung/c1skt/system.prop
		. build/envsetup.sh
       brunch c1skt
;;
ha)
		clear
		echo "ro.fullgreen.rom=haxynox" >> device/samsung/c1skt/system.prop
		. build/envsetup.sh
       lunch aosp_c1skt-userdebug
;;
om)
		clear
		echo "ro.fullgreen.rom=omnirom" >> device/samsung/i9300/system.prop
		. build/envsetup.sh
       brunch i9300
;;
esac
