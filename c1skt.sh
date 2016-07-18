#!/bin/bash
if [ -f ".used" ] then
	echo "이미 한번 이 스크립트를 실행했으므로 다시 하실 수 없습니다."
	# git clone 때문
else
	clear
	device=c1skt #기기명
	cms(sr){
		sudo add-apt-repository -y ppa:openjdk-r/ppa
		clear
		sudo apt-get -y update
		clear
		sudo apt-get -y install git-core python gnupg flex bison gperf libsdl1.2-dev libesd0-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-7-jre openjdk-7-jdk pngcrush schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev gcc-multilib liblz4-* pngquant ncurses-dev texinfo gcc gperf patch libtool automake g++ gawk subversion expat libexpat1-dev python-all-dev bc libcloog-isl-dev libcap-dev autoconf libgmp-dev build-essential gcc-multilib g++-multilib pkg-config libmpc-dev libmpfr-dev lzma* liblzma* w3m android-tools-adb maven ncftp htop
		clear
		mkdir ~/bin && curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo
		clear
		echo "소스를 다운로드 받으시겠습니까? [y/n]"
		read dow
		if [ $dow = 'y' ] then
			clear
			case "$sr" in
				cy)
					repo init -u git://github.com/CyanogenMod/android.git -b cm-13.0
					;;
				rr)
					repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b marshmallow
					;;
				bl)
					repo init -u https://github.com/BlissRoms/platform_manifest.git -b mm6.0
					;;
				te)
					repo init -u https://github.com/temasek/android.git -b cm-13.0
					;;
				fl)
					repo init -u git://github.com/FlareROM/android.git -b 1.0-MM
					;;
				ai)
					repo init -u https://github.com/AICP/platform_manifest.git -b mm6.0
					;;
				cr)
					repo init -u https://github.com/crdroidandroid/android -b 6.0.0
					;;
				na)
					repo init -u https://github.com/NamelessRom/android.git -b n-3.0
					;;
				xo)
					repo init -u git://github.com/XOSP-Project/platform_manifest.git -b xosp-mm
					;;
				ha)
					repo init -u git://github.com/Haxynox/platform_manifest.git -b Mmm
					;;
				om)
					repo init -u git://github.com/omnirom/android.git -b android-5.1
					;;
			esac
			clear
			echo "파일을 다운로드 받을 것입니다. 자신의 인터넷 회선이 좋다고 생각하십니까? [y|n]"
			read tru
			if [ $tru = 'y' ] then
				repo sync --force-sync -j20
			else if [ $tru = 'n'] then
				repo sync --force-sync -j10
			fi
			clear
			cp sms_patch.java frameworks/opt/telephony/src/java/com/android/internal/telephony/RIL.java
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
			export USE_CCACHE=1
			prebuilts/misc/linux-x86/ccache/ccache -M 50G
			prebuilts/misc/darwin-x86/ccache/ccache -M 50G
			clear
			echo "Executed" > .used
			if [ $bl = '1' ] then
				git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
				git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
			else
				git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt.git -b cm-13.0 device/samsung/c1skt
				git clone https://github.com/FullGreen/cyanogenmod_device_samsung_c1skt-common.git -b cm-13.0 device/samsung/c1skt-common
				git clone https://github.com/FullGreen/cyanogenmod_kernel_samsung_smdk4412.git -b cm-13.0 kernel/samsung/smdk4412
				git clone https://github.com/FullGreen/cyanogenmod_proprietary_vendor_samsung.git -b cm-13.0 vendor/samsung
				git clone https://github.com/CyanogenMod/android_packages_apps_SamsungServiceMode.git -b cm-13.0 packages/apps/SamsungServiceMode
				git clone https://github.com/CyanogenMod/android_external_stlport.git -b cm-13.0 external/stlport
				rm -rf hardware/samsung
				git clone https://github.com/FullGreen/cyanogenmod_hardware_samsung.git -b cm-13.0 hardware/samsung
			fi
			clear
			. build/envsetup.sh
			echo "이제 brunch c1skt 명령으로 빌드를 시작 해 주세요."
		else if [ $dow = 'n' ] then
			echo "그럼 아무것도 못합니다. 잘가세요."
			exit
		fi
	}
fi
echo $device "Build Script"
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
exit
