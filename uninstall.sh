#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future

MODPATH=${0%/*}

	rm -rf $MODPATH/addon 2>/dev/null
	rm -rf $MODPATH/common 2>/dev/null
	rm -f $MODPATH/install.sh 2>/dev/null
	
	system_ext_cache="
Settings
MiuiSystemUI
"
	system_cache="
Contacts
MonetContacts
MiuiSystemUIPlugin
MonetMiuiSystemUIPlugin
Mms
MonetMms
MiuiHome
MonetMiuiHome
FindDevice
MonetFindDevice
CloudBackup
MonetCloudBackup
CloudService
MonetCloudService
MiSound
MonetMiSound
NotificationCenter
MonetNotificationCenter
SecurityCenter
MonetSecurityCenter
MonetMiuiSystemUI
MonetSettings
"
	dda=/data/dalvik-cache/arm
	[ -d $dda"64" ] && dda=$dda"64"
	
	for i in $settings_cache; do
		rm -f $dda/system_ext@*@"$i"*
		rm -f /data/system/package_cache/*/"$i"*
	done
	
	for i in $other_cache; do
		rm -f $dda/system@*@"$i"*
		rm -f /data/system/package_cache/*/"$i"*
	done