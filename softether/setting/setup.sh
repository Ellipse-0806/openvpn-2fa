#!/bin/sh
vpnserver start
while ! pgrep vpnserver >/dev/null; do sleep 1; done
sleep 10
vpncmd localhost /SERVER /IN:/root/setting/softether-setting.ini
while true; do sleep 1000; done