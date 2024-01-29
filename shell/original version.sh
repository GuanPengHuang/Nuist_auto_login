
function demo(){
tar="10.255.255.34"
code=$(curl -I --connect-timeout 5 $tar -w %{http_code} | tail -n1)
if [ "$code" = 200 ]; then
 for n in wan macvlan1 macvlan2 macvlan3
  do
   echo $n
   HOST=$(ifconfig $n | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}')
   echo $HOST
   curl 'http://10.255.255.34/api/v1/login' -H 'Connection: keep-alive' -H 'Accept: application/json, text/plain, */*' -H 'DNT: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36' -H 'Content-Type: application/json;charset=UTF-8' -H 'Origin: http://10.255.255.34' -H 'Referer: http://10.255.255.34/authentication/login' -H 'Accept-Language: zh-CN,zh;q=0.9,zh-US;q=0.8' --data-raw '{"username":"15805162303","password":"123321","channel":"2","ifautologin":"1","pagesign":"secondauth","usripadd":"'${HOST}'"}'
   sleep 2
  done
 for i in wan macvlan4 macvlan5 macvlan6
  do
   HOST=$(ifconfig $i | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}')
   echo $HOST
   curl 'http://10.255.255.34/api/v1/login' -H 'Connection: keep-alive' -H 'Accept: application/json, text/plain, */*' -H 'DNT: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36' -H 'Content-Type: application/json;charset=UTF-8' -H 'Origin: http://10.255.255.34' -H 'Referer: http://10.255.255.34/authentication/login' -H 'Accept-Language: zh-CN,zh;q=0.9,zh-US;q=0.8' --data-raw '{"username":"17805107470","password":"690605","channel":"2","ifautologin":"1","pagesign":"secondauth","usripadd":"'${HOST}'"}'
   sleep 1
  done
else
 echo "f"
 ifdown wan
 for i in $(seq 1 6)
 do
     ifdown vwan$i
 done
 sleep 2
 ifup wan
 for a in $(seq 1 6)
 do
  ifup vwan$a
 done
 sleep 10
 demo
 exec >> $my.log 2>&1 
fi
}
demo