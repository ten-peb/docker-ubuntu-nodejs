# NodeJS on an Ubuntu 18.04 based container.

## Purpose

This container is intended to be a base container for end microservices.

## Repository Contents

* Dockerfile to create the image
* Jenkinsfile to define a miniature "pipeline" to allow Jenkins to publish the image to a local Docker engine or if the correct environmental values are set to a Docker registry.

## What's in the image?

* NodeJS version 11   (by default) 
* Yarn
* Puppet agent
* nagios-nrpe-agent

## OS/Version

Current OS is ubuntu/18.04 LTS


## Author: Peter L. Berghold <pberghold@tenna.com>

## Contributors

Specifications for this container were generated with input from:

* Luke Douglas
* Kelly Hickman
* Aditya Shah

## Change Log

### 2019-04-30   Inception: version 0.5.0
