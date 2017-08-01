#!/bin/bash
yarn jar ./share/hadoop/yarn/hadoop-yarn-applications-distributedshell-*.jar \
      -jar ./share/hadoop/yarn/hadoop-yarn-applications-distributedshell-*.jar \
      -shell_command "date" -num_containers 1
