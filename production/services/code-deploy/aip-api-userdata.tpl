#!/bin/bash

# userdata script for AIP installation
# prod web server version

#####
# common functions
#####

STDERR_FILE=/tmp/$$.stderr
log() {
echo $1 | logger -t user-data -s 2>/dev/console
}
log_if_error_with_stderr_file() {
  if [ "$1" -ne "0" ]; then
    echo "$2 (return code $1): $(cat $STDERR_FILE)" | logger -t user-data -s 2>/dev/console
  fi
}

##########
# actually do the things we want to do
##########

####
# web server specific
apt-get update
apt-get -y install nginx
service nginx start

#####
# Ubuntu-specific first section just to install awscli
# need to use pip version since Ubuntu distro is too old
####
apt-get -y install python-pip
pip install awscli


#####
# Ubuntu-specific main section
#####
#apt-get update
apt-get -y install python python-urllib3
## IMPORTANT: assumes quickstart Ubuntu AMI more recent than 20180627
snap install amazon-ssm-agent --classic
systemctl enable amazon-ssm-agent

#####
# AWS codedeploy
#####
apt-get -y install ruby wget openjdk-8-jre-headless
cd /home/ubuntu
wget https://aws-codedeploy-ap-northeast-2.s3.amazonaws.com/latest/install
chmod +x ./install
./install auto

