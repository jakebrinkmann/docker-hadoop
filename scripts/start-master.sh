#!/bin/bash

# Configure Hadoop
## Initialize Hadoop
bin/hdfs namenode -format -nonInteractive
sbin/start-dfs.sh
sbin/start-yarn.sh
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/root

/bin/bash

sbin/stop-yarn.sh
sbin/stop-dfs.sh

