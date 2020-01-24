#!/bin/bash
runuser -l hbase -c '/home/hbase/hbase/bin/start-hbase.sh && tail -f /dev/null'
