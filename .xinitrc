#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
/home/rule/programs/dwm-bar/dwm_bar.sh &
#/home/rule/.local/scripts/jack_startup.sh &
picom &
dunst &
bluetoothctl power on 

#!/bin/sh

# Turn off all monitors
#xrandr --output DP-1 --off
#xrandr --output DP-2 --off
#xrandr --output DP-3 --off
#xrandr --output HDMI-1 --off
#/home/rule/.screenlayout/with_tablet.sh


xsetwacom set "Wacom Cintiq 16 Pen stylus" MapToOutput HDMI-1
xsetwacom set "Wacom Cintiq 16 Pen eraser" MapToOutput HDMI-1


# Normalize DPI across all monitors
#xrandr --output DP-1 --dpi 96
#xrandr --output DP-2 --dpi 96
#xrandr --output DP-3 --dpi 96
#xrandr --output HDMI-1 --dpi 96

# Cursor theme and size
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=24
xsetroot -cursor_name left_ptr


# Turn on monitors in the desired order
#xrandr --output DP-2 --primary --mode 1920x1080 --pos 0x0 \
#       --output HDMI-1 --mode 1920x1080 --pos 1920x0 \
#       --output DP-3 --mode 1920x1080 --pos 3840x0


#xrandr --output DP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off --output DP-3 --mode 1920x1080 --pos 3840x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-1-2 --off --output DP-1-4 --off --output DP-1-5 --off --output DP-1-6 --off
feh --no-fehbg --bg-tile --auto-zoom '/home/rule/.local/synth_wallpaper.jpg'
while true; do
   dwm >/dev/null 2>&1
done

