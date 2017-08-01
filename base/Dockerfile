FROM centos:7
# Runtime Dependencies
WORKDIR /opt
RUN yum groupinstall -y "Development Tools" && \
	yum install -y wget which openssh-server && \
	yum clean all

## SSH configuration (! do NOT share this image !)
RUN ssh-keygen -A && \
	ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa && \
	cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
	chmod 0600 /root/.ssh/authorized_keys
COPY config/sshd_config /etc/ssh/sshd_config
COPY config/ssh_config /etc/ssh/ssh_config

## Install JAVA JDK 1.8.0
ENV JAVA_HOME "/usr/local/java"
RUN wget -nv -c --header "Cookie: oraclelicense=accept-securebackup-cookie" \
	http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz && \
	tar -zxf jdk-8u131-linux-x64.tar.gz && \
	rm jdk-8u131-linux-x64.tar.gz && \
	mv jdk1.8.0_131 $JAVA_HOME
ENV PATH="${PATH}:${JAVA_HOME}/bin"

## Install HADOOP 2.8.0
RUN groupadd hadoop
RUN useradd -d /home/hadoop -g hadoop -m hadoop
ENV HADOOP_HOME="/usr/local/hadoop"
RUN wget -nv "http://apache.claz.org/hadoop/common/hadoop-2.8.0/hadoop-2.8.0.tar.gz" && \
	tar -zxf hadoop-2.8.0.tar.gz && \ 
	mv hadoop-2.8.0 $HADOOP_HOME && \
	rm -Rf $HADOOP_HOME/share/doc && \
	chown -R hadoop:hadoop $HADOOP_HOME && \
	rm hadoop-2.8.0.tar.gz
ENV PATH="${PATH}:${HADOOP_HOME}/bin"

## Configure environment
COPY config/bashrc /root/.bashrc
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

