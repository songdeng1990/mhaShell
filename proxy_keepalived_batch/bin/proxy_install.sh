#!/bin/sh
localip=""
anotherip=""
vip=""
if=`ip addr | grep -E '172\.|192\.|10\.' | awk '{print $7}'`
yum install -y keepalived
mv /etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf.`date "+%Y%m%d%H%M%S"`.bak


