#!/usr/bin/python

import os
import json

t=os.popen("""sudo netstat -natp|awk -F: '/redis-server/&&/LISTEN/{print $2}'|awk '{print $1}'|uniq|sed '/^$/d' """)

ports = []

for port in  t.readlines():
        r = os.path.basename(port.strip())
        ports += [{'{#REDISPORT}':r}]

print json.dumps({'data':ports},sort_keys=True,indent=7,separators=(',',':'))
