#
# Copyright (C) 2024-2026 The AERA Recovery Project
# Copyright (C) 2023 TeamWin Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),cuscoi)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
