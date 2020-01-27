#Hadoop and Hbase container

## Version
* openjdk 11
* hadoop 3.2.1
* hbase 2.2.3


## Ports

|   Port    | Usage                         |
|-----------|-------------------------------|
|   9000    | hdfs port                     |
|   9001    | mapreduce job tracker port    |
|   9870    | Namenode http port            |
|   16000   | Hbase master port             |
|   16010   | Hbase master info port        |
|   16020   | Hbase region server port      |
|   16030   | Hbase regions erver info port |
|   2181    | Zookeeper port                |

## Docker build command
``
docker build . -t 'hbase:latest'
``
## Docker run command
``
docker run --rm -p 2181:2181 -p 16000:16000 -p 16020:16020 -p 16030:16030 -p 16010:16010 -t -d hbase:latest
``

