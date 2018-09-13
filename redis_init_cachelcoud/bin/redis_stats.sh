
#!/bin/bash


### OPTIONS VERIFICATION
if [ -z "$1" ];then
cat << EOF 
  [key]  [port]

Options:
	key   -- zabbix key item
	port     -- redis port (default 6379)
EOF
	exit 1
fi

### PARAMETERS
METRIC="$1"
HOSTNAME=127.0.0.1
#HOSTNAME="${2:-127.0.0.1}"
PORT="${2:-6379}"
CACHE_FILE="/tmp/redis_$PORT.cache"

### RUN
## Check cache file
(echo -en "INFO\r\n";sleep 1) | nc $HOSTNAME $PORT > $CACHE_FILE 2>/dev/null || exit 1
#fi

## output metrics
#grep "^$METRIC:" $CACHE_FILE | cut -d ":" -f 2
grep "^$METRIC:" $CACHE_FILE |awk -F':|,' '{print $2}'|sed "s/[^0-9]//g"
