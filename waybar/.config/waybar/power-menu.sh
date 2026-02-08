#!/bin/bash
options=" Power Off\n Reboot\n Lock\n Suspend\nHibernate\n Logout"
choice=$(echo -e "$options" | rofi -dmenu -i -p "Power" -location 2 -width 30 -lines 6 -bw 0 -padding 10 -opacity 90)

case "$choice" in
  " Power Off") systemctl poweroff ;;
  " Reboot") systemctl reboot ;;
  " Lock") loginctl lock-session ;;
  " Suspend") systemctl suspend ;;
  "Hibernate") systemctl hibernate ;;
  " Logout") loginctl terminate-user $USER ;;
esac
