#
# Copyright (C) 2024-2026 The AERA Recovery Project
# Copyright (C) 2023 TeamWin Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/twrp_cuscoi.mk \
    $(LOCAL_DIR)/aera_cuscoi_product.mk

COMMON_LUNCH_CHOICES := \
    twrp_cuscoi-user \
    twrp_cuscoi-userdebug \
    twrp_cuscoi-eng \
    aera_cuscoi-user \
    aera_cuscoi-userdebug \
    aera_cuscoi-eng
