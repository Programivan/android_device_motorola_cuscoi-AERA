#
# Copyright (C) 2024-2026 The AERA Recovery Project
# Copyright (C) 2023 TeamWin Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from product configurations. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Inherit TWRP / AERA vendor configs
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit hardware device configurations
$(call inherit-product, device/motorola/cuscoi/device.mk)

# Inherit AERA specific configs
$(call inherit-product, device/motorola/cuscoi/aera_cuscoi.mk)

PRODUCT_DEVICE := cuscoi
PRODUCT_NAME := twrp_cuscoi
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola edge 50 fusion
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=cuscoi_g \
    PRIVATE_BUILD_DESC="cuscoi-user 15 VUUI35HV-W1-ST23 06a6c6 release-keys"
BUILD_FINGERPRINT := motorola/cuscoi/cuscoi:15/VUUI35HV-W1-ST23/06a6c6:user/release-keys
