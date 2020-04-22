#!/bin/bash

# userdata script for AIP installation
# prod stream server version


#####
# Ubuntu-specific first section just to install awscli
# need to use pip version since Ubuntu distro is too old
####
apt-get update
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


