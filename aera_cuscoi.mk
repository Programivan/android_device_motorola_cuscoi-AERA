#
#	This file is part of the AERA Recovery Project
# 	Copyright (C) 2024-2026 The AERA Recovery Project
#
#	AERA is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	AERA is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#

# Screen settings
# Motorola Edge 50 Fusion (cuscoi) is 1080x2400 (20:9 pOLED).
# AERA renders against the adaptive 2400-high canvas and scales it cleanly.
AERA_MAINTAINER := AERA Recovery Team
AERA_UI2_ADAPTIVE_RESOLUTION := true
AERA_UI_ADAPTIVE_RESOLUTION := true
AERA_SCREEN_H := 2400
AERA_STATUS_H := 94
AERA_HIDE_NOTCH := 1
AERA_CLOCK_POS := 1
AERA_STATUS_INDENT_LEFT := 48
AERA_STATUS_INDENT_RIGHT := 48
AERA_ALLOW_DISABLE_NAVBAR := 0
AERA_USE_GREEN_LED := 0

# Partition and backup configuration
AERA_QUICK_BACKUP_LIST := /boot;/init_boot;/data;
AERA_ENABLE_LPTOOLS := 1
AERA_NO_TREBLE_COMPATIBILITY_CHECK := 1
AERA_DYNAMIC_FULL_SIZE := 9122611200
AERA_OPTIONS_LIST_NUM := 10

# Virtual A/B device with dedicated recovery partition
AERA_AB_DEVICE_WITH_RECOVERY_PARTITION := 1

# Data format & storage handling
# Ensure that /sdcard is bind-unmounted before f2fs data repair or format
AERA_UNBIND_SDCARD_F2FS := 1

# Automatically wipe /metadata after data format
AERA_WIPE_METADATA_AFTER_DATAFORMAT := 1

# Avoid MTP issues after data format
AERA_BIND_MOUNT_SDCARD_ON_FORMAT := 1

# Unmount emulated storage cleanly before rebooting or formatting
AERA_UNMOUNT_SDCARDS_BEFORE_REBOOT := 1

# Don't spam the console with loop errors
AERA_LOOP_DEVICE_ERRORS_TO_LOG := 1

# Compression
AERA_USE_LZ4_COMPRESSION := 1

# Partition tools
AERA_ENABLE_ALL_PARTITION_TOOLS := 1

# Enable FRP partition wipe support
AERA_ENABLE_FRP_WIPE := 1

# Device mapper control
AERA_USE_DMCTL := 1
AERA_USE_DMSETUP := 1

# Cuscoi ships prebuilt GKI kernel and f2fs/casefolded userdata
AERA_FORCE_PREBUILT_KERNEL := 1
AERA_FORCE_DATA_FORMAT_F2FS := 1
AERA_FORCE_CASEFOLDING := 1
AERA_DISABLE_ORS_AUTO_REBOOT := 1
AERA_USE_LOCKSCREEN_BUTTON := 1
AERA_ENABLE_WLAN := 1
