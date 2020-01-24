#Hbase standalone mode container

## Version
* openjdk 11
* hbase 2.2.3


## Ports

|   Port    |           Usage                   |
|-----------|-----------------------------------|
|   16000   |   HBase Master port               |
|   16010   |   HBase Master web UI             |
|   16020   |   HBase Region server port        |
|   16030   |   HBase Region server info port   |

## Docker build command
``
docker build . -t 'hbase-standalone:latest'
``
## Docker run command
``
docker run --rm -p 16000:16000 -p 16020:16020 -p 16030:16030 -p 16010:16010 -t -d hbase-standalone:latest
``
