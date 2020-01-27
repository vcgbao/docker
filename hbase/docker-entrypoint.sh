#!/bin/bash
service ssh start
runuser -l hadoop -c '/home/hadoop/hadoop/sbin/start-all.sh && /home/hadoop/hbase/bin/start-hbase.sh && tail -f /dev/null'
