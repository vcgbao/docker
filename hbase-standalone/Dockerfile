FROM ubuntu:16.04
MAINTAINER vcgbao vcgbao@gmail.com

ARG HBASE_DOWNLOAD_URL=https://www-us.apache.org/dist/hbase/2.2.3/hbase-2.2.3-bin.tar.gz
ARG JDK_DOWNLOAD_URL=https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz

# hbase user
ARG USER=hbase
ARG GROUP=hbase
ARG HOME=/home/hbase

# Java
ARG JAVA_HOME=$HOME/jdk

#Hbase
ARG HBASE_HOME=$HOME/hbase


# create hadoop user
RUN addgroup $GROUP && \
    adduser --disabled-password --geco "" --ingroup $GROUP $USER

RUN apt-get update && apt-get -y install wget

# swith to hbase user
USER $USER
WORKDIR $HOME

# setup java
RUN wget -q $JDK_DOWNLOAD_URL
RUN tar xzf openjdk-*.tar.gz && \
    mkdir jdk && \
    mv jdk-*/* jdk && \
    rmdir jdk-* && \
    rm openjdk-*.tar.gz
RUN echo "# set up JAVA_HOME\
export JAVA_HOME=$JAVA_HOME\
export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

# setup hbase
RUN wget -q $HBASE_DOWNLOAD_URL && \
    tar xzf hbase-*.tar.gz && \
    mkdir $HBASE_HOME && \
    mv hbase-*/* $HBASE_HOME && \
    rm hbase-*.tar.gz && \
    rmdir hbase-*

COPY configs/* $HBASE_HOME/conf/

RUN mkdir zookeeper

USER root
# clean apt-get dir
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 16000
EXPOSE 16010
EXPOSE 16020
EXPOSE 16030

ARG ENTRYPOINT=/usr/local/bin/docker-entrypoint.sh
COPY docker-entrypoint.sh $ENTRYPOINT
RUN chown -R $USER:$GROUP $ENTRYPOINT && chmod +x $ENTRYPOINT

RUN ln -s $ENTRYPOINT /
ENTRYPOINT ["docker-entrypoint.sh"]
