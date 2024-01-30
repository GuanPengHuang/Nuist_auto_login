#! /bin/sh
ping -c 1 8.8.8.8
if [ $? -eq 0 ]; then
	echo "You have connected!"
else
  echo 'wrong and try to connect eduroam'
  ifdown wwan;sleep 2;ifup wwan;sleep 60
  ping -c 1 8.8.8.8
  if [ $? -eq 0 ]; then
    echo "connected"
  else
    echo "restart netwrok"
    /etc/init.d/network restart;sleep 120
    ping -c 1 8.8.8.8
    if [ $? -eq 0 ]; then 
    echo "connected"
    else
    echo "reboot"
    /sbin/reboot
    fi
  fi
fi