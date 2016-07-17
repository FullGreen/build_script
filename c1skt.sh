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
#color                                                                #
#######################################################################

red='tput setaf 1'                 # Red
green='tput setaf 2'             # Green
yellow='tput setaf 3'           # Yellow
blue='tput setaf 4'               # Blue
violet='tput setaf 5'           # Violet
cyan='tput setaf 6'               # Cyan
white='tput setaf 7'             # White
clear

#######################################################################
#
#
#cyanogenmod
#
#
#######################################################################

#device=$2
device=c1skt
#G4 : g4
#NEXUS5 : hammerhead
#NEXUS5X : bullhead
#NOTE2 : t0lte
#GALAXYS5 : klte
#GALAXYS3 : i9300
#GALAXYS2 : i9100

cyanogenmod_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─cyanogenmod─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo 
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
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
ro.config.ringtone=Orion.ogg" > vendor/cm/config/telephony.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
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
else
tput setaf 2
echo "external/stlport[DOWNLOAD]"
tput setaf 3
git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
fi

tput setaf 4
. build/envsetup.sh
brunch c1skt

}

#######################################################################
#
#
#resurrectionremix
#
#
#######################################################################

resurrectionremix_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─resurrectionremix─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo 
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
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
ro.config.ringtone=Resurrection2.mp3" > vendor/cm/config/telephony.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
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
else
tput setaf 2
echo "external/stlport[DOWNLOAD]"
tput setaf 3
git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
fi

tput setaf 4
. build/envsetup.sh
brunch c1skt

}

#######################################################################
#
#
#blisspop
#
#
#######################################################################

blisspop_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─blisspop─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u https://github.com/BlissRoms/platform_manifest.git -b mm6.0
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo 
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/bliss/prebuilt/common/etc/apns-conf.xml
echo "# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
vendor/bliss/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Orion.ogg" > vendor/bliss/config/telephony.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

tput setaf 4
if [ -d device/samsung/c1skt ]
 then
     echo "디바이스 소스를 찾았습니다."
	 . build/envsetup.sh
	 brunch c1skt
 else
     echo "디바이스 소스를 찾을 수 없습니다."
     rm -Rf hardware/samsung
     git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
	 git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
	 . build/envsetup.sh
	 brunch c1skt	  
 fi  
}

#######################################################################
#
#
#temasek
#
#
#######################################################################

temasek_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─temasek─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u https://github.com/temasek/android.git -b cm-13.0
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
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
ro.config.ringtone=Orion.ogg" > vendor/cm/config/telephony.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
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
else
tput setaf 2
echo "external/stlport[DOWNLOAD]"
tput setaf 3
git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
fi

tput setaf 4
. build/envsetup.sh
brunch c1skt

}

#######################################################################
#
#
#flarerom
#
#
#######################################################################

flarerom_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─flarerom─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u git://github.com/FlareROM/android.git -b 1.0-MM
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
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
ro.config.ringtone=Orion.ogg" > vendor/cm/config/telephony.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
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
else
tput setaf 2
echo "external/stlport[DOWNLOAD]"
tput setaf 3
git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
fi

tput setaf 4
. build/envsetup.sh
brunch c1skt

}

#######################################################################
#
#
#aicp
#
#
#######################################################################

aicp_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─aicp─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u https://github.com/AICP/platform_manifest.git -b mm6.0
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/aicp/prebuilt/common/etc/apns-conf.xml
echo "# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
vendor/aicp/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Orion.ogg" > vendor/aicp/configs/telephony.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi
 
if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVaicp/aicp_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
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
else
tput setaf 2
echo "external/stlport[DOWNLOAD]"
tput setaf 3
git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
fi

tput setaf 4
. build/envsetup.sh
brunch c1skt

}

#######################################################################
#
#
#crdroidandroid
#
#
#######################################################################

crdroidandroid_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─crdroidandroid─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u https://github.com/crdroidandroid/android -b 6.0.0
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/crdroid/prebuilt/common/etc/apns-conf.xml
echo "# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
vendor/crdroid/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=Phobos.ogg" > vendor/cm/config/telephony.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi
 
if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVcrdroidandroid/crdroidandroid_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
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
else
tput setaf 2
echo "external/stlport[DOWNLOAD]"
tput setaf 3
git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
fi

tput setaf 4
. build/envsetup.sh
brunch c1skt
 
}

#######################################################################
#
#
#namelessrom
#
#
#######################################################################

namelessrom_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─namelessrom─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u https://github.com/NamelessRom/android.git -b n-3.0
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/nameless/prebuilt/common/etc/apns-conf.xml
echo "# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
vendor/nameless/prebuilt/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml" > vendor/nameless/config/apns.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVnamelessrom/namelessrom_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
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
else
tput setaf 2
echo "external/stlport[DOWNLOAD]"
tput setaf 3
git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
fi

tput setaf 4
. build/envsetup.sh
brunch c1skt 
 
}

#######################################################################
#
#
#xosp
#
#
#######################################################################

xosp_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─xosp─"
echo
echo
echo
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm
echo
echo
echo
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/xosp/prebuilt/common/etc/apns-conf.xml
echo "# Selective SPN list for operator number who has the problem.
PRODUCT_COPY_FILES += \
vendor/xosp/prebuilt/common/etc/selective-spn-conf.xml:system/etc/selective-spn-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
messaging \
Stk \
CellBroadcastReceiver

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
ro.config.ringtone=xperia.ogg" > vendor/xosp/config/telephony.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
else
tput setaf 2
echo "device/samsung/c1skt[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullgreenDEVxosp/xosp_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
fi

if [ -d device/samsung/c1skt-common ]; then 
tput setaf 1
echo "device/samsung/c1skt-common[PASS]"
tput setaf 3
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
else
tput setaf 2
echo "external/stlport[DOWNLOAD]"
tput setaf 3
git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
fi

if [ -d hardware/samsung ]; then 
tput setaf 1
echo "hardware/samsung[DELETE]"
rm -Rf hardware/samsung
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
else
tput setaf 2
echo "hardware/samsung[DOWNLOAD]"
tput setaf 3
git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
fi

tput setaf 4
. build/envsetup.sh
brunch c1skt 

}


#######################################################################
#
#
#haxynox
#
#
#######################################################################

haxynox_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─haxynox─"
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo
cp ha_sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

if [ -d device/samsung/c1skt ]; then 
tput setaf 1
echo "device/samsung/c1skt[PASS]"
tput setaf 3
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

tput setaf 4
. build/envsetup.sh
lunch c1skt
make -j8 otapackage
 
}

#######################################################################
#
#
#omnirom
#
#
#######################################################################

omnirom_Download_source()
{
echo "소스를 다운받으시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 source

if [ $source = 'no' ]; then
echo "소스 다운로드[PASS]"
else
echo "소스 다운로드[DOWNLOAD]"
tput setaf 1
echo "─omnirom─"
echo
echo
echo
echo "───────────────────────────────────────────────────"
echo "Install git"
echo "git 설치"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo init -u git://github.com/omnirom/android.git -b android-5.1
echo
echo
echo
echo "───────────────────────────────────────────────────"
echo "git installation complete"
echo "git 설치 완료"
echo "───────────────────────────────────────────────────"
echo
echo
echo

clear

tput setaf 2
echo
echo
echo
echo "───────────────────────────────────────────────────"
echo "Download source"
echo "소스 다운로드"
echo "───────────────────────────────────────────────────"
echo
echo
echo
repo sync --force-sync -j64
echo
echo "───────────────────────────────────────────────────"
echo "Source Download complete"
echo "소스 다운로드 완료"
echo "───────────────────────────────────────────────────"
echo

echo "Vendor의 apns-conf파일 삭제"
rm -f vendor/omni/prebuilt/etc/apns-conf.xml
echo "" > vendor/omni/config/cdma.mk
echo "# SIM Toolkit
PRODUCT_PACKAGES += \
Stk" > vendor/omni/config/gsm.mk
fi

tput setaf 3
clear
echo "ccache를 설정하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 ccache

if [ $ccache = 'no' ]; then
echo "ccache가 설정되지 않았습니다."
else
echo "ccache가 설정되었습니다."
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
prebuilts/misc/darwin-x86/ccache/ccache -M 50G
fi

clear
echo "소스를 정리하시겠습니까? │yes│ │no│"
echo "60초 뒤에 자동으로 │yes│가 입력됩니다."
read -t 60 clean

if [ $clean = 'no' ]; then
echo "소스를 정리하지 않습니다."
else
echo "소스를 정리합니다."
make clean
fi

if [ -d device/samsung/i9300 ]; then 
tput setaf 1
echo "device/samsung/i9300[PASS]"
tput setaf 3
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

tput setaf 4
. build/envsetup.sh
brunch i9300

}

#######################################################################
#buildtype
#######################################################################

buildtype()
{
echo "─buildtype─"

. build/envsetup.sh
clear

echo
echo
echo 
echo "───────────────────────────────────────────────────"
echo "Set buildtype"
echo "빌드종류 설정"
echo "───────────────────────────────────────────────────"
echo
echo
echo
export CM_BUILDTYPE="$device";

clear

}

case "$1" in
	cy)
		cyanogenmod_Download_source
		exit
		;;
	CY)
		cyanogenmod_Download_source
		exit
		;;
###############################
	rr)
		resurrectionremix_Download_source
		exit
		;;
	RR)
		resurrectionremix_Download_source
		exit
		;;
###############################
	bl)
		blisspop_Download_source
		exit
		;;
	BL)
		blisspop_Download_source
		exit
		;;
###############################
	te)
		temasek_Download_source
		exit
		;;
	TE)
		temasek_Download_source
		exit
		;;
###############################
	fl)
		flarerom_Download_source
		exit
		;;
	FL)
		flarerom_Download_source
		exit
		;;		
###############################
	ai)
		aicp_Download_source
		exit
		;;
	AI)
		aicp_Download_source
		exit
		;;		
###############################
	cr)
		crdroidandroid_Download_source
		exit
		;;
	CR)
		crdroidandroid_Download_source
		exit
		;;			
###############################
	na)
		namelessrom_Download_source
		exit
		;;
	NA)
		namelessrom_Download_source
		exit
		;;
###############################
	xo)
		xosp_Download_source
		exit
		;;
	XO)
		xosp_Download_source
	    exit
		;;
###############################
	ha)
		haxynox_Download_source
		exit
		;;
	HA)
		haxynox_Download_source
		exit
		;;
###############################
	om)
		omnirom_Download_source
		exit
		;;
	OM)
		omnirom_Download_source
		exit
		;;
###############################
###############################
###############################
	1)
		buildtype
		exit
		;;
esac	

clear

tput setaf 2
echo "┌───────────────────────────────────────────────────┐" 
echo "│Fullgreen BUILD Script[1.1.5.R1]                   │"
echo "└───────────────────────────────────────────────────┘"
echo " └ Made by Fullgreen┘" DEVICE : $device               
echo
echo "cy│ cyanogenmod Download source"
echo "rr│ resurrectionremix Download source"
echo "bl│ blisspop Download source/NOT READY"
echo "te│ temasek Download source"
echo "fl│ flarerom Download source"
echo "ai│ aicp Download source"
echo "cr│ crdroidandroid Download source"
echo "na│ namelessrom Download source"
echo "xo│ xosp Download source"
echo "ha│ haxynox Download source"
echo "om│ omni[LP] Download source"
echo
echo "1 │ BUILD TYPE(UNOFFICAL,NIGHTLY...)"

exit
