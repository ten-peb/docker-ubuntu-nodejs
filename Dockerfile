FROM ubuntu:18.04
LABEL com.tenna.vendor = "Tenna LLC"
LABEL com.tenna.author = "Peter L. Berghold <pberghold@tenna.com>"
LABEL com.tenna.description = "Ubuntu platform with NodeJS preinstalled"
LABEL com.tenna.version     = "0.5.0" 
RUN  export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get -y dist-upgrade && \
     apt-get -y install wget curl apt-utils build-essential gcc make
 RUN wget http://apt.puppetlabs.com/puppet-release-bionic.deb
 RUN dpkg -i puppet-release-bionic.deb
 RUN curl -sL https://deb.nodesource.com/setup_11.x | /bin/bash
 RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
    tee /etc/apt/sources.list.d/yarn.list
RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get -y install nodejs yarn puppet-agent nagios-nrpe-server \
                        monitoring-plugins monitoring-plugins-basic \
			nagios-plugins-contrib
