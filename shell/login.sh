
CURRENT_IP=$(ipconfig | grep inet | grep -v inet6 | grep -v 127 | grep -v 192 | awk '{print $(NF-2)}' | cut -d ':' -f2)
echo ${CURRENT_IP}
curl -X POST 'http://10.255.255.46/api/v1/login' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H 'DNT: 1' \
  -H 'Origin: http://10.255.255.46' \
  -H 'Referer: http://10.255.255.46/?LanmanUserURL=$USERURL' \
  --data-raw '{"username":"17805107470","password":"690605","channel":"2","ifautologin":"0","pagesign":"secondauth","usripadd":"'${CURRENT_IP}'"}' \
suspend