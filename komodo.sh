#! /bin/bash

# Just test building rom on drone ci (yes i know)


msg() {
	echo -e "\e[1;32m$*\e[0m"
}

makedir() {
	mkdir rom && cd rom
}

setup() {
	msg "====== Setup Env ======"

	git clone https://github.com/akhilnarang/scripts
	cd scripts
	bash setup/android_build_env.sh
	cd ../ && rm -rf scripts
      
	msg "====== Done ======"
}

sync() {
	msg "====== SYNC BITCH ======"
	repo init -u https://github.com/Komodo-OS-Rom/manifest -b ten --depth=1
	repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch
	git clone https://github.com/Reinazhard/android_device_xiaomi_whyred-1 device/xiaomi/whyred --depth=1
	git clone https://github.com/Reinazhard/android_device_xiaomi_sdm660-common-1 -b komodo device/xiaomi/sdm660-common --depth=1
	git clone https://github.com/Reinazhard/android_vendor_xiaomi_sdm660-common -b cr-8.0-hmp vendor/xiaomi/sdm660-common --depth=1
	git clone https://github.com/xiaomi-sdm660/android_vendor_xiaomi_whyred vendor/xiaomi/whyred --depth=1
	git clone https://github.com/Jhonse02/vendor_MiuiCamera vendor/MiuiCamera --depth=1
	git clone https://github.com/MocaRafee/ExtendedKernel-Whyred kernel/xiaomi/sdm660 -b xt-eas --depth=1
       
	msg "====== Done Bitch ======"
}

build() {
	msg "====== Lunching ======"
        
	. b*/e*
	lunch komodo_whyred-userdebug
	masak komodo -j$(nproc --all)
	msg "====== Done ======"
}


makedir
setup
sync
build
        
