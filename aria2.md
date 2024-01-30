1.2 安裝Aira2
切換至base源，然後輸入以下命令

opkg update && opkg install libstdcpp
切換至packages源，然後輸入以下命令

opkg update && opkg install aria2

二. 配置Aria2
創建配置文件 aria2.conf
我這裏的路徑爲/etc/aria2/aria2.conf

## '#'開頭爲註釋內容, 選項都有相應的註釋說明, 根據需要修改 ##
## 被註釋的選項填寫的是默認值, 建議在需要修改時再取消註釋  ##

## 文件保存相關 ##
k
# 文件的保存路徑(可使用絕對路徑或相對路徑), 默認: 當前啓動位置
dir=/mnt/sda3/download
# 啓用磁盤緩存, 0爲禁用緩存, 需1.16以上版本, 默認:16M
#disk-cache=128M
# 文件預分配方式, 能有效降低磁盤碎片, 默認:prealloc
# 預分配所需時間: none < falloc ? trunc < prealloc
# falloc和trunc則需要文件系統和內核支持
# NTFS建議使用falloc, EXT3/4建議trunc, MAC 下需要註釋此項
file-allocation=trunc
# 斷點續傳
continue=true

## 下載連接相關 ##

# 最大同時下載任務數, 運行時可修改, 默認:5
max-concurrent-downloads=1
# 同一服務器連接數, 添加時可指定, 默認:1
max-connection-per-server=5
# 最小文件分片大小, 添加時可指定, 取值範圍1M -1024M, 默認:20M
# 假定size=10M, 文件爲20MiB 則使用兩個來源下載; 文件爲15MiB 則使用一個來源下載
min-split-size=10M
# 單個任務最大線程數, 添加時可指定, 默認:5
split=5
# 整體下載速度限制, 運行時可修改, 默認:0
#max-overall-download-limit=0
# 單個任務下載速度限制, 默認:0
#max-download-limit=0
# 整體上傳速度限制, 運行時可修改, 默認:0
#max-overall-upload-limit=0
# 單個任務上傳速度限制, 默認:0
#max-upload-limit=0
# 禁用IPv6, 默認:false
disable-ipv6=false

## 進度保存相關 ##

# 從會話文件中讀取下載任務
input-file=/mnt/sda1/aria2/aria2.session
# 在Aria2退出時保存`錯誤/未完成`的下載任務到會話文件
save-session=/mnt/sda1/aria2/aria2.session
# 定時保存會話, 0爲退出時才保存, 需1.16.1以上版本, 默認:0
#save-session-interval=60

## RPC相關設置 ##

# 啓用RPC, 默認:false
enable-rpc=true
# 允許所有來源, 默認:false
rpc-allow-origin-all=true
# 允許非外部訪問, 默認:false
rpc-listen-all=true
# 事件輪詢方式, 取值:[epoll, kqueue, port, poll, select], 不同系統默認值不同
#event-poll=select
# RPC監聽端口, 端口被佔用時可以修改, 默認:6800
#rpc-listen-port=6800
# 設置的RPC授權令牌, v1.18.4新增功能, 取代 --rpc-user 和 --rpc-passwd 選項
#rpc-secret=<TOKEN>
# 設置的RPC訪問用戶名, 此選項新版已廢棄, 建議改用 --rpc-secret 選項
#rpc-user=<USER>
# 設置的RPC訪問密碼, 此選項新版已廢棄, 建議改用 --rpc-secret 選項
#rpc-passwd=<PASSWD>
並手動創建 aria2.session 文件

在本地啓動腳本中添加aria2c -c --conf-path=/etc/aria2/aria2.conf -D