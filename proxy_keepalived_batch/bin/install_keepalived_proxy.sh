#!/bin/sh
local_ip="172.20.1.1"
another_ip="172.20.1.4"
tmp_ip_store=""
vip="172.20.1.241"

if=`ip addr | awk '{if($2~/^(172\.|192\.|10\.)/) print $NF}'`
name="互链脉搏官网"
dingdingrobot="https://oapi.dingtalk.com/robot/send?access_token=3647e8264c9c94bca62d4d389e2321c0331e2d9155145fa7aeaed847321ba1a0"
conf_file=/etc/keepalived/keepalived.conf
notify_file=/etc/keepalived/notify.sh

ip addr | grep $local_ip
if [ $? -ne 0 ];then
	tmp_ip_store=$local_ip
	local_ip=$another_ip
	another_ip=$tmp_ip_store
fi

yum install -y keepalived

mv $conf_file $conf_file.`date "+%Y%m%d%H%M%S"`.bak
rm -f $notify_file
cp keepalived.template $conf_file
cp notify.template $notify_file

sed -i "s/@name/$name/g"  $notify_file
sed -i "s#@dingdingrobot#$dingdingrobot#g"  $notify_file

sed -i "s/@if/$if/g" $conf_file
sed -i "s/@local_ip/$local_ip/g" $conf_file
sed -i "s/@another_ip/$another_ip/g" $conf_file
sed -i "s/@vip/$vip/g" $conf_file
chmod -R 700 /etc/keepalived
service keepalived start
#install proxysql
tar xvf proxysql.tar.gz -C /usr/local/
chmod -R 700 /usr/local/proxysql
cd /usr/local/proxysql/bin;./proxysqlServer.sh start


