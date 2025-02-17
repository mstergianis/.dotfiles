dbus-update-activation-environment --systemd DISPLAY
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

/home/michael/.local/bin/key-reset

export TERMINAL="alacritty"
xrdb -merge .Xresources
xsetroot -cursor_name left_ptr

# set background
# ~/.fehbg &

# udiskie automatic mounting
# udiskie &

export LC_ALL=en_US.UTF-8

export FONTCONFIG_PATH=/etc/fonts

# nvidia specific config
xrandr --setprovideroutputsource modesetting NVIDIA-0
autorandr -l pc-wide
nitrogen --restore

exec i3 -V >> ~/.i3log/i3log-$(date +'%F-%k-%M-%S') 2>&1 
# xpmroot ~/Pictures/background.xpm &
# exec bash $HOME/.fehbg
# exec xmonad

