#!/bin/sh
export PATH='/etc/storage/bin:/tmp/script:/etc/storage/script:/opt/usr/sbin:/opt/usr/bin:/opt/sbin:/opt/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin'
export LD_LIBRARY_PATH=/lib:/opt/lib

if [ $1 == "up" ] ; then
    nvram set dnspod_status=0
    nvram set dns_com_pod_status=0
    nvram set cloudflare_status=0
    nvram set cloudxns_status=0
    nvram set aliddns_status=0
    nvram set qcloud_status=0
    nvram set ngrok_status=0
    nvram set kcptun_status=0
    nvram set tinyproxy_status=0
    nvram set mproxy_status=0
    #nvram set lnmp_status=0
    nvram set vpnproxy_status=0
    nvram set mentohust_status=0
    nvram set ss_status=0
    nvram set FastDicks_status=0
    nvram set display_status=0
    nvram set ssserver_status=0
    nvram set ssrserver_status=0
    nvram set wifidog_status=0
    nvram set frp_status=0
    nvram set serverchan_status=0
    nvram set softether_status=0
    nvram set cow_status=0
    nvram set meow_status=0
    nvram set ddnsto_status=0
fi

if [ -f /tmp/webui_yes ] ; then
    /etc/storage/script0_script.sh
    chmod 777 /etc/storage/script -R
    logger -t "【WebUI】" "UI 开关遍历状态监测"
    killall menu_title.sh 
    [ -f /etc/storage/www_sh/menu_title.sh ] && /etc/storage/www_sh/menu_title.sh 
    # start all services Sh??_* in /etc/storage/script
    for i in `ls /etc/storage/script/Sh??_* 2>/dev/null` ; do
        [ ! -x "${i}" ] && continue
        [ ! -f /tmp/webui_yes ] && continue
        eval ${i}
    done
    /tmp/sh_theme.sh &
else
    logger -t "【WebUI】" "稍等后启动相关设置"
fi
[ -f /tmp/crontabs.lock ] && exit 0
touch /tmp/crontabs.lock
http_username=`nvram get http_username`
cat > "/tmp/crontabs_DOMAIN.txt" <<-\EOF
# 基本格式 : 
# 0　　*　　*　　*　　*　　command 
# 分　时　日　月　周　命令 
# 在以上各个字段中，还可以使用以下特殊字符：
# 第一个数字（分钟）不能为*
# 星号（*）：代表所有可能的值，例如month字段如果是星号，则表示在满足其它字段的制约条件后每月都执行该命令操作。
# 逗号（,）：可以用逗号隔开的值指定一个列表范围，例如，“1,2,5,7,8,9”
# 中杠（-）：可以用整数之间的中杠表示一个整数范围，例如“2-6”表示“2,3,4,5,6”
# 正斜线（/）：可以用正斜线指定时间的间隔频率，例如“0-23/2”表示每两小时执行一次。同时正斜线可以和星号一起使用，例如*/10，如果用在minute字段，表示每十分钟执行一次。
 #删除开头的#启动命令 ：自定义设置 - 脚本 - 自定义 Crontab 定时任务配置
# 定时运行脚本规则 (删除前面的#即可启动命令)

# 每天的三点半重启
#30 3 * * * reboot & #删除开头的#启动命令
# 每星期一的三点半重启
#30 3 * * 1 reboot & #删除开头的#启动命令

# 下午6点定自动切换中继信号脚本【自动搜寻信道、自动搜寻信号】
#0 18 * * * /etc/storage/script/sh_ezscript.sh connAPSite_scan

# 凌晨2点定时关网：
#0 2 * * * stop_wan #删除开头的#启动命令

# 早上8点定时开网（重启wan口）：
#0 8 * * * restart_wan #删除开头的#启动命令

# 每天的一点【切换WAN模式】和【重启wan口】
30 6 * * * /tmp/sh_wan_wips.sh wan & #删除开头的#启动命令
# 每天的十点切换wifi中继模式
15 0 * * * /tmp/sh_wan_wips.sh wips & #删除开头的#启动命令

# 每6小时重启迅雷快鸟
#15 */6 * * * [ "`nvram get FastDick_enable`" = "1" ] && nvram set FastDicks_status=00 && /tmp/script/_Fast_Dick & #删除开头的#启动命令

# 每3小时重启迅雷下载
#5 */3 * * * [[ $(ps -w | grep "/xunlei/lib/" | grep -v "grep" | wc -l) == 3 ]] && killall EmbedThunderManager & #删除开头的#启动命令

# 每1小时重启花生壳内网版
#10 */1 * * * [ "`nvram get phddns`" = "1" ] && killall oraynewph && killall oraysl & #删除开头的#启动命令

# 每1小时重启DNSPod 域名解析
#13 */1 * * * nvram set dnspod_status=123 && /tmp/script/_dnspod & #删除开头的#启动命令

# 每1小时重启CloudXNS 域名解析
#16 */1 * * * nvram set cloudxns_status=123 && /tmp/script/_cloudxns & #删除开头的#启动命令

# 每1小时重启Cloudflare 域名解析
#16 */1 * * * nvram set cloudflare_status=123 && /tmp/script/_cloudflare & #删除开头的#启动命令

# 每1小时重启aliddns 域名解析
#16 */1 * * * nvram set aliddns_status=123 && /tmp/script/_aliddns & #删除开头的#启动命令

# 每1小时重启aliddns 域名解析
#16 */1 * * * nvram set qcloud_status=123 && /tmp/script/_qcloud & #删除开头的#启动命令

# 早上8点开启微信推送：
#0 8 * * * nvram set serverchan_enable=1 && nvram set serverchan_status=0 && /tmp/script/_server_chan & #删除开头的#启动命令

# 晚上10点关闭微信推送：
#0 22 * * * nvram set serverchan_enable=0 && nvram set serverchan_status=0 && /tmp/script/_server_chan & #删除开头的#启动命令

# 这里只能修改以上命令，如需自定义命令去【 系统管理 - 服务 - 计划任务 (Crontab)】设置


EOF
chmod 777 "/tmp/crontabs_DOMAIN.txt"

reboot_mode=`nvram get reboot_mode`
if [ "$reboot_mode" = "1" ] ; then
    reboot_hour=`nvram get reboot_hour`
    reboot_hour=`expr $reboot_hour + 0 `
    [ "$reboot_hour" -gt 23 ] && reboot_hour=23 && nvram set reboot_hour=$reboot_hour
    [ "$reboot_hour" -le 0 ] && reboot_hour=0 && nvram set reboot_hour=$reboot_hour
    reboot_minute=`nvram get reboot_minute`
    reboot_minute=`expr $reboot_minute + 0 `
    [ "$reboot_minute" -gt 59 ] && reboot_minute=59 && nvram set reboot_minute=$reboot_minute
    [ "$reboot_minute" -le 0 ] && reboot_minute=0 && nvram set reboot_minute=$reboot_minute
    echo "$reboot_minute $reboot_hour * * * reboot #删除开头的#启动命令" >> /tmp/crontabs_DOMAIN.txt
fi

if [ -z "`grep '删除开头的#启动命令' /etc/storage/cron/crontabs/$http_username`" ] ; then
echo "" > /etc/storage/cron/crontabs/$http_username
else
sed -Ei '/删除开头的/d' /etc/storage/cron/crontabs/$http_username
fi
grep '删除开头的' /tmp/crontabs_DOMAIN.txt | grep -v '^#' | sort -u | grep -v "^$" > /tmp/crontabs_DOMAIN2.txt
grep '删除开头的' /tmp/crontabs_DOMAIN2.txt | grep -v '^#' | sort -u | grep -v "^$" > /tmp/crontabs_DOMAIN.txt
grep -v '^#' /etc/storage/cron/crontabs/$http_username | sort -u | grep -v "^$" >> /tmp/crontabs_DOMAIN.txt
grep -v '^#' /tmp/crontabs_DOMAIN.txt | sort -u | grep -v "^$" > /etc/storage/cron/crontabs/$http_username
cat > "/tmp/sh_wan_wips.sh" <<-\EOF
#!/bin/sh
logger -t "【WAN、WIFI中继开关】" "切换模式:$1"
restartwan()
{
logger -t "【WAN、WIFI中继开关】" "重新链接 WAN"
restart_wan
sleep 10
logger -t "【WAN、WIFI中继开关】" "重新启动 2.4G WIFI"
radio2_restart
}
case "$1" in
wan)
#无线AP工作模式："0"=【AP（桥接被禁用）】"1"=【WDS桥接（AP被禁用）】"2"=【WDS中继（网桥 + AP）】"3"=【AP-Client（AP被禁用）】"4"=【AP-Client + AP】
nvram set rt_mode_x=0
nvram commit
restartwan

  ;;
wips)
#无线AP工作模式："0"=【AP（桥接被禁用）】"1"=【WDS桥接（AP被禁用）】"2"=【WDS中继（网桥 + AP）】"3"=【AP-Client（AP被禁用）】"4"=【AP-Client + AP】
nvram set rt_mode_x=3
nvram commit
restartwan

  ;;
esac

EOF
chmod 777 "/tmp/sh_wan_wips.sh"

[ "$upscript_enable" = "1" ] && cru.sh a upscript_update "1 1 * * * /etc/storage/script/sh_upscript.sh &" &
[ "$upscript_enable" != "1" ] && cru.sh d upscript_update &

/etc/storage/ap_script.sh crontabs &
rm -f /tmp/crontabs.lock
