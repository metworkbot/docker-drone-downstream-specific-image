FROM centos:centos7

RUN yum -y install wget && wget -O /drone_linux_amd64.tar.gz https://github.com/drone/drone-cli/releases/download/v0.8.6/drone_linux_amd64.tar.gz && zcat /drone_linux_amd64.tar.gz |tar xvf - && cp -f /drone /usr/bin/drone && rm -f /drone*

ADD drone.sh /usr/bin/drone.sh
ENTRYPOINT /usr/bin/drone.sh
