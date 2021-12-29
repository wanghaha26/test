#!/bin/sh
yum install bind-utils -y
yum install wget -y && wget https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz
[ -e /root/AdGuardHome_linux_amd64.tar.gz ]
if [ $? -eq 0 ]
then
        yum install tar -y
        tar AdGuardHome_linux_amd64.tar.gz
else
        echo "下载失败，请稍后再试"
        exit;
fi
cd AdGuardHome
./AdguardHome -s install
Mon="/root/AdGuardHome"
if [ ! -d $Mon ]
then
	exit;
fi	
read -p "AdGuardHome：" SERVICE
netstat -anp | grep $SERVICE &> /dev/null
if [ $? -eq 0 ]
then
  	echo "$SERVICE服务已经启动！"
else
  	echo "$SERVICE服务启动失败！"
        exit;
fi
echo “正在开放3000端口”
firewall-cmd —permanent —zone=public —add-port=3000/tcp
firewall-cmd —permanent —zone=public —add-port=3000/udp
ufw allow 3000
echo "AdGuardHome安装成功，感谢您的使用”	
