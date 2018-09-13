confFile="/etc/masterha/proxy_app_default.cnf"
utilFile="/etc/masterha/app1/scripts/mysql_proxy_util"
failoverFile="/etc/masterha/app1/scripts/master_ip_failover_proxy"
failoverOnline="/etc/masterha/app1/scripts/master_ip_online_change_proxy"
reportFile="/etc/masterha/app1/scripts/send_report_proxy"
alertFile="/etc/masterha/app1/scripts/alert.sh"
task_name="互链脉搏官网"
dingdingrobot="https://oapi.dingtalk.com/robot/send?access_token=3647e8264c9c94bca62d4d389e2321c0331e2d9155145fa7aeaed847321ba1a0"

port=22
mhapwd=sJospqA_8s1H
replpwd=onethinG2018
masterip=172.20.1.1
slaveip=172.20.1.4
secondCheckIP=172.20.1.7

yum install perl perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker perl-DBD-MySQL perl-Config-Tiny perl-Log-Dispatch perl-Parallel-ForkManager perl-Config-IniFiles -y

rpm -ivh --force node.rpm manager.rpm 
tar xvf mha_manager_conf.tar.gz -C /etc/
sed -i "s/@sshport/$port/g" $confFile
sed -i "s/@mhapwd/$mhapwd/g" $confFile
sed -i "s/@replpwd/$replpwd/g" $confFile
sed -i "s/@masterip/$masterip/g" $confFile
sed -i "s/@slaveip/$slaveip/g" $confFile
sed -i "s/@secondCheckIP/$secondCheckIP/g" $confFile
       
sed -i "s/@masterip/$masterip/g" $utilFile
sed -i "s/@slaveip/$slaveip/g" $utilFile

sed -i "s#@robot#$dingdingrobot#g" $alertFile
sed -i "s#@name#$task_name#g" $alertFile

chmod +x /etc/masterha/app1/scripts/*
chmod 700 /etc/masterha
