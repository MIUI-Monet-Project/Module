##########################################################################################
#
# Magisk Module Installer Script
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure and implement callbacks in this file
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
#
##########################################################################################

##########################################################################################
# Config Flags
##########################################################################################

# Set to true if you do *NOT* want Magisk to mount
# any files for you. Most modules would NOT want
# to set this flag to true
SKIPMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=false

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=false

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info why you would need this

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here
REPLACE="
"

##########################################################################################
#
# Function Callbacks
#
# The following functions will be called by the installation framework.
# You do not have the ability to modify update-binary, the only way you can customize
# installation is through implementing these functions.
#
# When running your callbacks, the installation framework will make sure the Magisk
# internal busybox path is *PREPENDED* to PATH, so all common commands shall exist.
# Also, it will make sure /data, /system, and /vendor is properly mounted.
#
##########################################################################################
##########################################################################################
#
# The installation framework will export some variables and functions.
# You should use these variables and functions for installation.
#
# ! DO NOT use any Magisk internal paths as those are NOT public API.
# ! DO NOT use other functions in util_functions.sh as they are NOT public API.
# ! Non public APIs are not guranteed to maintain compatibility between releases.
#
# Available variables:
#
# MAGISK_VER (string): the version string of current installed Magisk
# MAGISK_VER_CODE (int): the version code of current installed Magisk
# BOOTMODE (bool): true if the module is currently installing in Magisk Manager
# MODPATH (path): the path where your module files should be installed
# TMPDIR (path): a place where you can temporarily store files
# ZIPFILE (path): your module's installation zip
# ARCH (string): the architecture of the device. Value is either arm, arm64, x86, or x64
# IS64BIT (bool): true if $ARCH is either arm64 or x64
# API (int): the API level (Android version) of the device
#
# Availible functions:
#
# ui_print <msg>
#     print <msg> to console
#     Avoid using 'echo' as it will not display in custom recovery's console
#
# abort <msg>
#     print error message <msg> to console and terminate installation
#     Avoid using 'exit' as it will skip the termination cleanup steps
#
# set_perm <target> <owner> <group> <permission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     this function is a shorthand for the following commands
#       chown owner.group target
#       chmod permission target
#       chcon context target
#
# set_perm_recursive <directory> <owner> <group> <dirpermission> <filepermission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     for all files in <directory>, it will call:
#       set_perm file owner group filepermission context
#     for all directories in <directory> (including itself), it will call:
#       set_perm dir owner group dirpermission context
#
##########################################################################################
##########################################################################################
# If you need boot scripts, DO NOT use general boot scripts (post-fs-data.d/service.d)
# ONLY use module scripts as it respects the module status (remove/disable) and is
# guaranteed to maintain the same behavior in future Magisk releases.
# Enable boot scripts by setting the flags in the config section above.
##########################################################################################

# Set what you want to display when installing your module
print_modname() {
	ui_print " "
	ui_print "===================================================="
	ui_print "  MIUI Monet Project"
	ui_print " "
	sleep 0.05
	ui_print "  If you have any bugs or issues, please report to"
	# ui_print "  please report them to"
	sleep 0.05
	ui_print "  Telegram User:  @geoorg30"
	sleep 0.05
	ui_print "  Telegram Group: @MIUIMonet"
	sleep 0.05
	ui_print "===================================================="
	sleep 0.3
}

# Copy/extract your module files into $MODPATH in on_install.
on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
	ui_print " "
	#  ui_print "- Extracting module files"
	unzip -o "$ZIPFILE" -d $MODPATH >&2
	ui_print "- Checking requirements"
	ui_print " "
	sleep 1
	print_specs
	check_api
	sleep 1
	ui_print " "
	ui_print "- Installing files"
	install_files
	sleep 1
	ui_print "- Cleaning up"
	cleanup
	sleep 1
	ui_print "- Installation complete"
	sleep 2
	print_credits
}

# Only some special files require specific permissions
# This function will be called after on_install is done
# The default permissions should be good enough for most cases
set_permissions() {
  # The following is the default rule, DO NOT remove
  set_perm_recursive $MODPATH 0 0 0755 0644
  
  # Here are some examples:
  # set_perm_recursive  $MODPATH/system/lib       0     0       0755      0644
  # set_perm  $MODPATH/system/bin/app_process32   0     2000    0755      u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0     2000    0755      u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0     0       0644
}

# You can add more functions to assist your custom script code


# Install module files
install_files() {

	. $MODPATH/addon/Volume-Key-Selector/install.sh

	ui_print " "
	ui_print "- What version for settings app would you like"
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
		1 ) Version="default";;
		2 ) Version="themed";;
	esac

	sleep 1
	cp -rf $MODPATH/common/settings/${Version}/MonetSettings.apk $MODPATH/system/product/overlay
	ui_print " "
	ui_print "- $TEXT for settings installed"
}

MINAPI=31
# Check for min/max api version
check_api() {
	[ -z $MINAPI ] || { [ $API -lt $MINAPI ] && abort "  Your system API of $API is less than the minimum required api of $MINAPI! Aborting!"; }
	[ -z $MAXAPI ] || { [ $API -gt $MAXAPI ] && abort "  Your system API of $API is greater than the maximum required api of $MAXAPI! Aborting!"; }
}

Manufacturer=$(getprop ro.product.vendor.manufacturer)
Model=$(getprop ro.product.vendor.model)
Version=$(getprop ro.build.version.incremental)
Android=$(getprop ro.build.version.release)
CPU_ABI=$(getprop ro.product.cpu.abi)
# output some system spec.
print_specs() {
	ui_print "===================================================="
	sleep 0.05
	ui_print "- Device:           $Model"
	sleep 0.05
   # ui_print "- Manufacturer:     $Manufacturer"
   # sleep 0.05
   # ui_print "- ARM Version:      $CPU_ABI"
   # sleep 0.05
	ui_print "- SDK Version:      $API"
	sleep 0.05
	ui_print "- Android Version:  Android $Android"
	sleep 0.05
	ui_print "- Build version:    $Version"
	ui_print "===================================================="
	sleep 0.3
}

# cleanup extra files & junk after installation
cleanup() {
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
	
	for i in $system_ext_cache; do
		rm -f $dda/system_ext@*@"$i"*
		rm -f /data/system/package_cache/*/"$i"*
	done
	
	for i in $system_cache; do
		rm -f $dda/system@*@"$i"*
		rm -f /data/system/package_cache/*/"$i"*
	done
}

print_credits() {
	ui_print " "
	ui_print "===================================================="
	ui_print "  If you found this module helpful, please consider"
	ui_print "  supporting the development."
	ui_print "  You can donate at https://paypal.me/geoorg"
	ui_print "  All support is appreciated."
	ui_print " "
	ui_print " "
	ui_print "  Made with ❤️"
	ui_print "===================================================="
	sleep 0.3
}