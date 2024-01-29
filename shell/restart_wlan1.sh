#! /bin/sh
HOST=$(ifconfig wlan1 | grep inet | grep -v inet6 | grep -v 127 | grep -v 6.6 | grep -v 192 | awk '{print $(NF-2)}' | cut -d ':' -f2)
  echo $HOST
ping -I wlan1 -c 1 www.baidu.com
if [ $? -eq 0 ]; then
	echo "You have connected!"
else
  echo "Trying to connect"
  /sbin/ifdown wan
  ping -I wlan1 -c 1 www.baidu.com
  if [ $? -eq 0 ]; then
	  echo "You have connected!"
  fi
fi
