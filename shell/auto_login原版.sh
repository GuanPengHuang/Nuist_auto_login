#! /bin/sh
function network()
{
    #超时时间
    local timeout=1
    #目标网站
    local target=www.baidu.com
    #获取响应状态码
    local ret_code=`curl -I -s --connect-timeout ${timeout} ${target} -w %{http_code} | tail -n1`
    if [ "x$ret_code" = "x200" ]; then
        #网络畅通
        return 1
    else
        #网络不畅通
        return 0
    fi
    return 0
}
network
if [ $? -eq 0 ];then
	echo "网络不畅通，请检查网络设置！"
  #注意本机IP
  HOST=$(ifconfig | grep inet | grep -v inet6 | grep -v 127 | grep -v 10.10.10 | grep -v 192 | awk '{print $(NF-2)}' | cut -d ':' -f2)
	curl 'http://10.255.255.34/api/v1/login' -H 'Connection: keep-alive' -H 'Accept: application/json, text/plain, */*' -H 'DNT: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -H 'Content-Type: application/json;charset=UTF-8' -H 'Origin: http://10.255.255.34' -H 'Referer: http://10.255.255.34/authentication/login' -H 'Accept-Language: zh-CN,zh;q=0.9,zh-US;q=0.8' --data-raw '{"username":"15805162303","password":"123321","channel":"2","ifautologin":"1","pagesign":"secondauth","usripadd":"'${HOST}'"}'
  exit -1
fi
echo "网络畅通，你可以上网冲浪！"
exit 0
echo "xxxxxxxxxxxxxxxxxxxxxxxx"
