#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future

MODPATH=${0%/*}
OVERLAYS="`ls $MODPATH/system/product/overlay`"
    
for OVERLAY in $OVERLAYS; do
    rm -f `find /data/system/package_cache -type f -name *$OVERLAY*`
    rm -f `find /data/dalvik-cache -type f -name *$OVERLAY*.apk`
done