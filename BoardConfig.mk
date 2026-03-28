#
# BoardConfig.mk for Xiaomi Peridot SHRP Recovery
#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2025 The OrangeFox Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Allow minimal manifest builds
ALLOW_MISSING_DEPENDENCIES := true

###################
# SHRP FLAGS
###################

# Mandatory
SHRP_DEVICE_CODE := peridot
SHRP_PATH := device/xiaomi/peridot
SHRP_MAINTAINER := @khargosxh18
SHRP_REC_TYPE := Normal
SHRP_DEVICE_TYPE := A/B
SHRP_REC := /dev/block/bootdevice/by-name/recovery
SHRP_HAS_RECOVERY_PARTITION := true
SHRP_AB := true

# Important
SHRP_EDL_MODE := 1
SHRP_INTERNAL := /sdcard
SHRP_EXTERNAL := /external_sd
SHRP_OTG := /usb_otg
SHRP_FLASH := 1

# Optional
SHRP_EXPRESS := true
SHRP_EXPRESS_USE_DATA := true
SHRP_DARK := true
SHRP_CUSTOM_FLASHLIGHT := false
SHRP_NO_SAR_AUTOMOUNT := false
SHRP_LITE := false

# Default Addons
SHRP_SKIP_DEFAULT_ADDON_1 := true
INC_IN_REC_ADDON_1 := false
SHRP_SKIP_DEFAULT_ADDON_2 := false
INC_IN_REC_ADDON_2 := true
SHRP_SKIP_DEFAULT_ADDON_3 := false
INC_IN_REC_ADDON_3 := true
SHRP_SKIP_DEFAULT_ADDON_4 := false
INC_IN_REC_ADDON_4 := true
INC_IN_REC_MAGISK := true
SHRP_EXCLUDE_MAGISK_FLASH := false

###################
# Architecture
###################

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := $(TARGET_ARCH_VARIANT)
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := $(TARGET_CPU_VARIANT)

###################
# Power & Scheduler
###################

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

###################
# Bootloader
###################

PRODUCT_PLATFORM := pineapple
TARGET_BOOTLOADER_BOARD_NAME := peridot
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

###################
# Platform
###################

TARGET_BOARD_PLATFORM := pineapple
TARGET_BOARD_PLATFORM_GPU := qcom-adreno735
QCOM_BOARD_PLATFORMS += xiaomi_sm8635

###################
# Kernel
###################

BOARD_KERNEL_PAGESIZE := 4096
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
BOARD_USES_GENERIC_KERNEL_IMAGE := true

BOARD_RAMDISK_USE_LZ4 := true

###################
# A/B Handling
###################

BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    vbmeta \
    vbmeta_system \
    odm \
    product \
    system \
    system_ext \
    system_dlkm \
    vendor \
    vendor_dlkm

###################
# Verified Boot
###################

BOARD_AVB_ENABLE := true

###################
# Partitions
###################

BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600  # 100MB

BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm

BOARD_PARTITION_LIST := $(call to-upper, $(BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := erofs))
$(foreach p, $(BOARD_PARTITION_LIST), $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

###################
# Recovery
###################

BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

###################
# Crypto & Decryption
###################

FIXED_DECRYPT := false
TW_INCLUDE_CRYPTO := $(FIXED_DECRYPT)
TW_INCLUDE_CRYPTO_FBE := $(FIXED_DECRYPT)
TW_INCLUDE_FBE_METADATA_DECRYPT := $(FIXED_DECRYPT)
BOARD_USES_QCOM_FBE_DECRYPTION := $(FIXED_DECRYPT)
TW_USE_FSCRYPT_POLICY := 2
BOARD_USES_METADATA_PARTITION := true

###################
# Version & Security
###################

PLATFORM_VERSION := 99.87.36
PLATFORM_SECURITY_PATCH := 2127-12-31
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

###################
# Board Info
###################

TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

###################
# Tools & Debug
###################

TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_LPDUMP := true
TW_INCLUDE_LPTOOLS := true

TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace

TW_INCLUDE_FASTBOOTD := true

###################
# TWRP Config
###################

TW_THEME := portrait_hdpi
TW_FRAMERATE := 120
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_NO_EXFAT_FUSE := false
TW_USE_TOOLBOX := true
TARGET_USES_MKE2FS := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_EXTRA_LANGUAGES := false
TW_DEFAULT_LANGUAGE := en
TW_DEFAULT_BRIGHTNESS := 200
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
TW_HAS_EDL_MODE := true

###################
# Haptics
###################

FIXED_HAPTICS := false
ifeq ($(FIXED_HAPTICS),true)
   TW_SUPPORT_INPUT_AIDL_HAPTICS := true
   TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/vibratorfeature"
   TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
else
   TW_NO_HAPTICS := true
endif

TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko focaltech_3683g.ko focaltech_touch.ko goodix_core.ko goodix_ts.ko nxp-nci.ko qti_battery_charger.ko xiaomi_touch.ko"
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone48/temp"
TW_BATTERY_SYSFS_WAIT_SECONDS := 6
