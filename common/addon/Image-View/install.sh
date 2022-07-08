image_view() {
if [ "$1" ]; then
  local pic="$1"
else
  for i in png jpg jpeg; do
    [ -f "$MODPATH/common/addon/Image-View/image.$i" ] && { local pic="image.$i"; break; }
  done
fi
[ "$pic" ] || { ui_print " No image detected!"; return 1; }
for i in album gallery image photo *; do
  local app="$(dumpsys package r | grep -A6 ".dir/image" | cut -d" " -f10 | cut -d"/" -f1 | sort | egrep -i "$i" | uniq | head -n1)"
  [ "$app" ] && break
done
[ "$app" ] || { ui_print " Image display not supported! Skipping"; return 1; }
cp -f $MODPATH/common/addon/Image-View/$pic $TMPDIR/$pic 2>/dev/null
chcon u:object_r:system_file:s0 $TMPDIR/$pic
(am start --user 0 -a android.intent.action.VIEW -t image/* -d file://$TMPDIR/$pic $app) >/dev/null && sleep 3 && killall $app || ui_print " Error displaying image! Skipping"; 
}
