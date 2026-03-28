#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2025 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
#!/bin/sh
#
# SHRP 14.1 vendorsetup.sh for Xiaomi Peridot
# Auto-exports environment variables for build
#

FDEVICE="peridot"

shrp_get_target_device() {
	export script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
	if echo "$script_path" | grep -q "$FDEVICE"; then
		SHRP_BUILD_DEVICE="$FDEVICE"
	elif echo "$0" | grep -q "$FDEVICE"; then
		SHRP_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$SHRP_BUILD_DEVICE" ]; then
	shrp_get_target_device
fi

if [ "$SHRP_BUILD_DEVICE" = "$FDEVICE" ]; then
	echo "Detected SHRP build device: $SHRP_BUILD_DEVICE"

	# -------------------------------
	# Mandatory SHRP flags
	# -------------------------------
	export SHRP_DEVICE_CODE=peridot
	export SHRP_PATH=device/xiaomi/peridot
	export SHRP_MAINTAINER=@khargosxh18
	export SHRP_REC_TYPE=Normal
	export SHRP_DEVICE_TYPE=A/B
	export SHRP_REC=/dev/block/bootdevice/by-name/recovery
	export SHRP_HAS_RECOVERY_PARTITION=true
	export SHRP_AB=true

	# -------------------------------
	# Storage
	# -------------------------------
	export SHRP_INTERNAL=/sdcard
	export SHRP_EXTERNAL=/external_sd
	export SHRP_OTG=/usb_otg

	# -------------------------------
	# Flashlight
	# -------------------------------
	export SHRP_FLASH=1
	export SHRP_CUSTOM_FLASHLIGHT=false

	# -------------------------------
	# Optional & Express
	# -------------------------------
	export SHRP_EXPRESS=true
	export SHRP_EXPRESS_USE_DATA=true
	export SHRP_DARK=true
	export SHRP_NO_SAR_AUTOMOUNT=false
	export SHRP_LITE=false

	# -------------------------------
	# Compression & Ramdisk
	# -------------------------------
	export BOARD_RAMDISK_USE_LZ4=true
	export OF_USE_LZ4_COMPRESSION=1
	export OF_USE_LZMA_COMPRESSION=0

	# -------------------------------
	# Magiskboot / patching
	# -------------------------------
	export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1

	# -------------------------------
	# Crypto / Decryption
	# -------------------------------
	export FIXED_DECRYPT=false
	export TW_INCLUDE_CRYPTO=$FIXED_DECRYPT
	export TW_INCLUDE_CRYPTO_FBE=$FIXED_DECRYPT
	export TW_INCLUDE_FBE_METADATA_DECRYPT=$FIXED_DECRYPT
	export BOARD_USES_QCOM_FBE_DECRYPTION=$FIXED_DECRYPT
	export TW_USE_FSCRYPT_POLICY=2
	export OF_KEEP_DM_VERITY=1
	export OF_KEEP_FORCED_ENCRYPTION=1
	export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1
	export OF_SKIP_FBE_DECRYPTION=0

	# -------------------------------
	# A/B options
	# -------------------------------
	export FOX_AB_DEVICE=1
	export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
	export OF_RECOVERY_AB_FULL_REFLASH_RAMDISK=0

	# -------------------------------
	# Maintainer / Build version
	# -------------------------------
	export FOX_MAINTAINER_PATCH_VERSION=01

else
	echo "I: SHRP vendorsetup.sh skipped; device mismatch or environment issue."
fi
