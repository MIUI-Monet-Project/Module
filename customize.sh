SKIPUNZIP=0
SKIPMOUNT=false
Manufacturer=$(getprop ro.product.vendor.manufacturer)
Codename=$(getprop ro.product.device)
Model=$(getprop ro.product.vendor.model)
Build=$(getprop ro.build.version.incremental)
Android=$(getprop ro.build.version.release)
CPU_ABI=$(getprop ro.product.cpu.abi)
MIUI=$(getprop ro.miui.ui.version.code)
MODVER=`grep_prop version $MODPATH/module.prop`
MINMIUI=13
MINSDK=31
MAXSDK=0

# Set what you want to display when installing your module
print_modname() {
	ui_print " "
	ui_print "===================================================="
	ui_print "  MIUI Monet Project $MODVER"
	ui_print " "
	sleep 0.05
	ui_print "  If you have any bugs or issues, please report to"
	sleep 0.05
	ui_print "  Telegram User:  @geoorg30"
	sleep 0.05
	ui_print "  Telegram Group: @MIUIMonet"
	sleep 0.05
	ui_print "===================================================="
	sleep 0.5
}
      

# Install module files
install_files() {
    . $MODPATH/addon/Volume-Key-Selector/install.sh

	ui_print " "
	ui_print "- What version for Settings app would you like"
	ui_print "  to install?"
	ui_print " "
	ui_print "    1. Default icons"
	ui_print "    2. Themed icons"
	ui_print " "
	ui_print "    Volume up (+) to change version"
	ui_print "    Volume down (-) to install version"
	ui_print " "
	sleep 0.5
	A=1
	while true; do
		case $A in
			1 ) TEXT="Default icons";;
			2 ) TEXT="Themed icons";;
		esac
		ui_print "    $A. $TEXT"
		if $VKSEL 60; then
			A=$((A + 1))
		else
			break
		fi
		if [ $A -gt 2 ]; then
			A=1
		fi
	done
	case $A in
		1 ) Version="Default";;
		2 ) Version="Themed";;
	esac
	sleep 1
	if [ $Version -eq 'Default' ]
	    then
	    cp -rf $MODPATH/common/Settings/${Version}/MonetSettings.apk $MODPATH/system/product/overlay
    else
	    cp -rf $MODPATH/common/Settings/${Version}/MIUI${MIUI}/MonetSettings.apk $MODPATH/system/product/overlay
    fi
            
	ui_print " "
	ui_print "- $TEXT for Settings app installed"
	
	aod=$(pm list packages com.miui.aod 2>&1)
	if [ ! -z $aod ]
	    then
        ui_print " "
        ui_print "- Installing for Always-on display";
        cp -rf $MODPATH/common/MonetMiuiAod.apk $MODPATH/system/product/overlay
    fi

	mirror=$(pm list packages com.xiaomi.mirror 2>&1)
	if [ ! -z $mirror ]
	    then
        ui_print " "
        ui_print "- Installing for MIUI+";
        cp -rf $MODPATH/common/MonetMirror.apk $MODPATH/system/product/overlay
    fi

	cleaner=$(pm list packages com.miui.cleanmaster 2>&1)
	if [ ! -z $cleaner ]
	    then
        ui_print " "
        ui_print "- Installing for China Cleaner";
        cp -rf $MODPATH/common/Cleaner/MonetCleanMaster.apk $MODPATH/system/product/overlay
    fi

    cleaner=$(pm list packages com.miui.cleaner 2>&1)
	if [ ! -z $cleaner ]
	    then
        ui_print " "
        ui_print "- Installing for Global Cleaner";
        cp -rf $MODPATH/common/Cleaner/MonetCleanMasterGlobal.apk $MODPATH/system/product/overlay
    fi

    fileexplorer=$(pm list packages com.android.fileexplorer 2>&1)
	if [ ! -z $fileexplorer ]
	    then
        ui_print " "
        ui_print "- Installing for China File Manager";
        cp -rf $MODPATH/common/FileExplorer/MonetFileExplorer.apk $MODPATH/system/product/overlay
    fi

    fileexplorer=$(pm list packages com.mi.android.globalFileexplorer 2>&1)
	if [ ! -z $fileexplorer ]
	    then
        ui_print " "
        ui_print "- Installing for Global File Manager";
        cp -rf $MODPATH/common/FileExplorer/MonetFileExplorerGlobal.apk $MODPATH/system/product/overlay
    fi
}

# output some system spec.
print_specs() {
	ui_print "===================================================="
	sleep 0.05
	ui_print "- Device:           $Model"
	sleep 0.05
    ui_print "- Manufacturer:     $Manufacturer"
    sleep 0.05
	ui_print "- SDK Platform:     API level $API"
	sleep 0.05
	ui_print "- Android Version:  Android $Android"
	sleep 0.05
	ui_print "- MIUI Version:     MIUI $MIUI"
	sleep 0.05
	ui_print "- Build version:    $Build"
	ui_print "===================================================="
	sleep 0.3
}

# Check for min/max api version
check_sdk() {
	local error=false
	if [ $MINSDK -gt 0 -a $MINSDK -gt $API ]
	    then
		ui_print " "
		ui_print "  Your SDK version $API is less than the required ";
		ui_print "  SDK version. ";
		error=true
    fi

	if [ $MAXSDK -gt 0 -a $MAXSDK -lt $API ]
	    then
		ui_print " "
		ui_print "  Your SDK version $API is higher than the required ";
		ui_print "  SDK version. ";
		error=true
    fi

	if $error; then
		abort
	fi
}

# check minimum MIUI version 
check_miui() {
	local error=false
	if [ $MINMIUI -gt 0 -a $MIUI -lt $MINMIUI ]
	    then
		ui_print " "
		ui_print "  Your MIUI version $MIUI is less than the required ";
		ui_print "  MIUI version. ";
		error=true
    fi

	if $error; then
		abort
	fi
	
}

# cleanup extra files & junk after installation
cleanup() {
	rm -rf $MODPATH/addon 2>/dev/null
	rm -rf $MODPATH/common 2>/dev/null
	rm -f $MODPATH/install.sh 2>/dev/null
	rm -f $MODPATH/LICENSE 2>/dev/null

    OVERLAYS="`ls $MODPATH/system/product/overlay`"
    
    for OVERLAY in $OVERLAYS; do
        rm -f `find /data/system/package_cache -type f -name *$OVERLAY*`
        rm -f `find /data/dalvik-cache -type f -name *$OVERLAY*.apk`
    done

}

print_credits() {
	ui_print "===================================================="
	ui_print "  If you found this module helpful, please consider"
	ui_print "  supporting the development."
	ui_print "  You can donate at https://paypal.me/geoorg"
	ui_print "  or buymeacoffee at https://buymeacoffee.com/geoorg"
	ui_print "  All support is appreciated."
	ui_print " "
	ui_print " "
	ui_print "  Made with ❤️"
	ui_print "===================================================="
	sleep 0.3
}

# main installer
run_install() {
	ui_print " "
#	unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >&2
	print_modname
	sleep 1
    ui_print " "
	ui_print "- Checking requirements"
	ui_print " "
	sleep 1
	print_specs
	sleep 1
	check_sdk
	check_miui
	ui_print " "
	ui_print "- Installing files"
	sleep 0.5
	install_files
	sleep 1
    ui_print " "
	ui_print "- Installation complete"
    sleep 1
	ui_print " "
	ui_print "- Cleaning up"
	ui_print " "
	cleanup
	sleep 2
	print_credits
#	ui_print " "
}

# start the installation
run_install