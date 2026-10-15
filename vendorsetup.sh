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

FDEVICE="cuscoi"

aera_get_target_device() {
	local script_path
	script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
	if echo "$script_path" | grep -q "/$FDEVICE$"; then
		AERA_BUILD_DEVICE="$FDEVICE"
	elif echo "$0" | grep -q "$FDEVICE"; then
		AERA_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$AERA_BUILD_DEVICE" ]; then
	aera_get_target_device
fi

if [ "$1" = "$FDEVICE" ] || [ "$AERA_BUILD_DEVICE" = "$FDEVICE" ]; then
	export LC_ALL="C"
	export ALLOW_MISSING_DEPENDENCIES=true
	export AERA_AB_DEVICE=1
	export AERA_VIRTUAL_AB_DEVICE=1
	export AERA_VANILLA_BUILD=1
	export AERA_PRODUCT_PREFIX=AERA
	export AERA_BUILD_STATUS=Official
	export AERA_BUILD_TYPE=Beta
	export AERA_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export AERA_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"

	# Bundled binaries & utilities
	export AERA_USE_BASH_SHELL=1
	export AERA_USE_TAR_BINARY=1
	export AERA_USE_SED_BINARY=1
	export AERA_USE_LZ4_BINARY=1
	export AERA_USE_ZSTD_BINARY=1
	export AERA_USE_DATE_BINARY=1
	export AERA_USE_GREP_BINARY=1
	export AERA_USE_BUSYBOX_BINARY=1
	export AERA_USE_XZ_UTILS=1
	export AERA_USE_NANO_EDITOR=1
	export AERA_DELETE_AROMAFM=1
	export AERA_DELETE_MAGISK_ADDON=1
	export AERA_USE_UPDATED_MAGISKBOOT=1
	export AERA_USE_FSCK_EROFS_BINARY=1
	export AERA_USE_PATCHELF_BINARY=1

	# Recovery settings directories
	export AERA_SETTINGS_ROOT_DIRECTORY=/data/recovery
	export AERA_MISCELLANEOUS_ROOT_DIRECTORY=/sdcard
	export AERA_ALLOW_EARLY_SETTINGS_LOAD=1

	# Device aliases and variants for Motorola Edge 50 Fusion
	export TARGET_DEVICE_ALT="cuscoi,cuscoi_g,XT2429-1,XT2429-2,XT2429-3,XT2429-4"
	export AERA_TARGET_DEVICES="$TARGET_DEVICE_ALT"
	export AERA_ENABLE_ROOT_MANAGER=1

	# AERA starts at R1.0; clear legacy patch suffixes
	unset AERA_VARIANT
	unset AERA_MAINTAINER_PATCH_VERSION
fi
