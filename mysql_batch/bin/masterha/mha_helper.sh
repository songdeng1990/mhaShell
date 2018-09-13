masterha_home=/etc/masterha
masterha_conf=$masterha_home/proxy_app_default.cnf
#masterha_conf=$masterha_home/app_default.cnf
ip_inner=`ifconfig -a | grep -w inet | grep -v 127.0.0.1 | egrep  '^192\.|172\.|10\.' | awk '{print $2}'`
masterha_manager --conf=$masterha_conf --ignore_last_failover > $masterha_home/app1/stdout.log 2>&1 
if [ $? -ne 0 ];then
        /etc/masterha/app1/scripts/alert.sh "mysql 主从切换" "$ip_inner's master is dead.but failover failed.check the log"
else
	/etc/masterha/app1/scripts/alert.sh "mysql 主从切换" "$ip_inner's mha manager finished"
fi
