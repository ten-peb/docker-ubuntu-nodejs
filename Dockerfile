FROM ubuntu:18.04
LABEL com.tenna.vendor = "Tenna LLC"
LABEL com.tenna.author = "Peter L. Berghold <pberghold@tenna.com>"
LABEL com.tenna.description = "Ubuntu platform with NodeJS preinstalled"
LABEL com.tenna.version     = "0.5.0"
# Arguments begin here
ARG NodeJSVersion = 11
# Enough Arguments!
#
# Update the OS, grab some essential tools to make all this work 
RUN  export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get -y dist-upgrade && \
     apt-get -y install wget curl apt-utils build-essential gcc make git

# Grab the repository definition(s) for Puppet products 
RUN wget http://apt.puppetlabs.com/puppet-release-bionic.deb
RUN dpkg -i puppet-release-bionic.deb

# Grab the repository definitions for the correct version of NodeJS

RUN curl -sL https://deb.nodesource.com/setup_${NodeJSVersion}.x | /bin/bash

# Predefine the node userid
RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

# Grab the PUBKEY for yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

# Setup the yarn repository 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
    tee /etc/apt/sources.list.d/yarn.list

# Grab all the goodness that this image needs. 
RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get -y install nodejs yarn puppet-agent nagios-nrpe-server \
                        monitoring-plugins monitoring-plugins-basic \
			nagios-plugins-contrib
