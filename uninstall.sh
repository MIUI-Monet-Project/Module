#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future

MODPATH=${0%/*}

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
	CleanMaster
	MonetCleanMaster
	MonetCleanMasterGlobal
	FileExplorer
	MIUIFileExplorerGlobal
	MonetFileExplorer
	MonetFileExplorerGlobal
"
cache_path=/data/dalvik-cache/arm
[ -d $cache_path"64" ] && cache_path=$cache_path"64"

for i in $system_ext_cache; do
	rm -f $cache_path/system_ext@*@"$i"*
	rm -f /data/system/package_cache/*/"$i"*
done

for i in $system_cache; do
	rm -f $cache_path/system@*@"$i"*
	rm -f /data/system/package_cache/*/"$i"*
done

# for APPS in $APP; do
#  rm -f `find /data/system/package_cache /data/dalvik-cache /data/resource-cache -type f -name *$APPS*`
# done