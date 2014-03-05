#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge .Xresources && 


# Start xscreensaver daemon, the config are located in .xscreensaver
( ( sleep 10 && /usr/bin/xscreensaver -no-splash -display :0.0 ) & )

# start apps in background (only if not already running)
[[ -z "$(pidof mpd)" ]] && mpd
[[ -z "$(pidof urxvtd)" ]] && urxvtd -q -o -f

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec awesome >> ~/.cache/awesome/stdout 2 >> ~/.cache/awesome/stderr
