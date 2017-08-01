
Configures and provisions a single master and single slave [Apache™ Hadoop®!](https://hadoop.apache.org/) nodes, using Docker

## Installation

Build the [base Hadoop image](/base/Dockerfile) in Docker:
```bash
make build
# docker build -t hadoop-base ./base/
```

This will install the following dependencies:
* Java JDK 1.8.0
* Hadoop 2.8.0

Grab a coffee, it takes some time to download/unpack/install. 

* Final image size: `hadoop-base: 1.099 GB`


## Running

Bring the container-network online in the background: 
```bash
make up
# docker-compose up -d
```

Once provisioned, hop into the running containers:
```bash
make j-master
# docker exec -it hadoop-master /bin/bash
make j-slave
# docker exec -it hadoop-slave1 /bin/bash
```

## Start the HDFS daemons

On the master node:
```bash
./start-master.sh
# bin/hdfs namenode -format -nonInteractive
# sbin/start-dfs.sh
# sbin/start-yarn.sh
```

At this point, the NameNode and the ResourceManager web-apps become available.

Watch out for any errors running on the slave: 
```bash
tail -f logs/hadoop-root-datanode-hadoop-slave1.log
tail -f logs/yarn-root-nodemanager-hadoop-slave1.log
```

Make sure things are running, from the master:
```bash
bin/hdfs dfsadmin -report
bin/hdfs getconf -namenodes
```

### Create Jobs

To create a simple map-reduce task:
```bash
./launch-mapred-job.sh
# bin/hdfs dfs -put etc/hadoop input
# bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar \
#        grep input output 'dfs[a-z.]+'
# bin/hdfs dfs -get output output
```

To create a distributed shell task:
```bash
./launch-shell-job.sh
# yarn jar ./share/hadoop/yarn/hadoop-yarn-applications-distributedshell-*.jar \
#       -jar ./share/hadoop/yarn/hadoop-yarn-applications-distributedshell-*.jar \
#       -shell_command "date" -num_containers 1
```

The output should be found: 
```bash
cat logs/userlogs/application_<id>/container_<id>/stdout
```

Note: container ID is managed by YARN.

## Shutdown

To properly shutdown the container network (started in the background)
```bash
make down
# docker-compose down
```

## Quick Links

* [NameNode - http://localhost:50070/](http://localhost:50070/)
* [ResourceManager - http://localhost:8088/](http://localhost:8088/)
* [NodeManager - http://localhost:8042/](http://localhost:8042/)

## References

* [Hadoop: Setting up a Single Node Cluster.](http://hadoop.apache.org/docs/r2.8.0/hadoop-project-dist/hadoop-common/SingleCluster.html)
* [Hadoop: Fully-Distributed Operation](https://hadoop.apache.org/docs/r2.8.0/hadoop-project-dist/hadoop-common/ClusterSetup.html)
* TODO: https://www.tutorialspoint.com/hadoop/hadoop_multi_node_cluster.htm
* TODO: http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-multi-node-cluster

