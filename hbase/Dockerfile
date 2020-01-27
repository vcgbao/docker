FROM ubuntu:16.04
MAINTAINER vcgbao vcgbao@gmail.com

# Download urls
ARG JDK_DOWNLOAD_URL=https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz
ARG HADOOP_DOWNLOAD_URL=https://www-eu.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
ARG HBASE_DOWNLOAD_URL=https://www-us.apache.org/dist/hbase/2.2.3/hbase-2.2.3-bin.tar.gz

# Hadoop user
ARG USER=hadoop
ARG GROUP=hadoop
ARG HOME=/home/hadoop
ARG SSH_DIR=$HOME/.ssh

# Java
ARG JAVA_HOME=$HOME/jdk
ARG HADOOP_HOME=$HOME/hadoop

# Hadoop
ARG DATA_DIR=$HOME/data
ARG HADOOP_TMP=$DATA_DIR/tmp
ARG HADOOP_STORE=$DATA_DIR/hadoop_store
ARG HADOOP_LOG_DIR=$HOME/logs/hadoop

#Hbase
ARG HBASE_HOME=$HOME/hbase
ARG ZOOKEEPER_DATA_DIR=$DATA_DIR/zookeeper

ARG TMP=/tmp

ARG ENTRYPOINT=/usr/local/bin/docker-entrypoint.sh

# install ssh
RUN apt-get update && apt-get -y install openssh-server openssh-client

# create hadoop user
RUN addgroup $GROUP && \
    adduser --disabled-password --geco "" --ingroup $GROUP $USER

ADD $JDK_DOWNLOAD_URL $TMP
ADD $HADOOP_DOWNLOAD_URL $TMP
ADD $HBASE_DOWNLOAD_URL $TMP

RUN chown $USER:$GROUP $TMP/*.tar.gz

# swith to hadoop user
USER $USER
WORKDIR $HOME

# setup java
RUN tar xzf $TMP/openjdk-*.tar.gz && \
    mkdir jdk && \
    mv jdk-*/* jdk && \
    rmdir jdk-*
RUN printf "# set up JAVA_HOME\n\
export JAVA_HOME=$JAVA_HOME\n\
export PATH=\$PATH:\$JAVA_HOME/bin\n" >> ~/.bashrc

# setup ssh
RUN mkdir $SSH_DIR && \
    echo "$SSH_DIR/id_rsa\n\n" | ssh-keygen -t rsa && \
    cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

# setup hadoop
RUN tar xzf $TMP/hadoop-*.tar.gz && \
    mkdir $HADOOP_HOME && \
    mv hadoop-*/* $HADOOP_HOME && \
    rmdir hadoop-*

RUN printf "export HADOOP_INSTALL=$HADOOP_HOME\n\
export PATH=\$PATH:\$HADOOP_INSTALL/bin\n\
export PATH=\$PATH:\$HADOOP_INSTALL/sbin\n\
export HADOOP_MAPRED_HOME=\$HADOOP_INSTAL\n\
export HADOOP_COMMON_HOME=\$HADOOP_INSTALL\n\
export HADOOP_HDFS_HOME=\$HADOOP_INSTALL\n\
export YARN_HOME=\$HADOOP_INSTALL\n\
export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_INSTALL/lib/native\n\
export HADOOP_OPTS=-Djava.library.path=\$HADOOP_INSTALL/lib" >> ~/.bashrc

RUN mkdir -p $HADOOP_TMP && \
    mkdir -p $HADOOP_STORE && \
    mkdir -p $HADOOP_STORE/hdfs/ && \
    mkdir -p $HADOOP_STORE/hdfs/namenode && \
    mkdir -p $HADOOP_STORE/hdfs/datanode && \
    mkdir -p $HADOOP_LOG_DIR

COPY --chown=$USER:$GROUP configs/hadoop/* $HADOOP_HOME/etc/hadoop/

RUN cd $HADOOP_HOME && ./bin/hdfs namenode -format

RUN mkdir -p $ZOOKEEPER_DATA_DIR

# setup hbase
RUN tar xzf $TMP/hbase-*.tar.gz && \
    mkdir $HBASE_HOME && \
    mv hbase-*/* $HBASE_HOME && \
    rmdir hbase-*

COPY --chown=$USER:$GROUP configs/hbase/* $HBASE_HOME/conf/

USER root
# clean apt-get dir
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000 9001 9870 9871 16000 16010 16020 16030 2181

COPY --chown=$USER:$GROUP docker-entrypoint.sh $ENTRYPOINT
RUN chmod +x $ENTRYPOINT

RUN ln -s $ENTRYPOINT /
ENTRYPOINT ["docker-entrypoint.sh"]
