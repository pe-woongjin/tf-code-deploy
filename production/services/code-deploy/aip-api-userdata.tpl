#!/bin/bash

# userdata script for AIP installation
# prod web server version

#####
# specific to launch template
#####
USER_LIST_CSV=alp-prod-users.csv

#####
# WJ-ALP constants the same across all launch templates
#####
USER_S3_BUCKET=wjtb-prd-config
USER_S3_PREFIX=aip/ssh-user-info
USER_S3_SSH_KEYS_PREFIX=aip/ssh-user-info/keys/
SUDO_GROUP=sudo
USERADD=useradd
USER_CSV_S3_URL=""s3://$USER_S3_BUCKET/$USER_S3_PREFIX/$USER_LIST_CSV""

#####
# constants which are the same in all contexts for this version of this script
#####
# used by user setup based on S3 info
EXTRACTION_REGEX='^([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)$'
STDERR_FILE=/tmp/$$.stderr

#####
# common functions
#####
log() {
echo $1 | logger -t user-data -s 2>/dev/console
}
log_if_error_with_stderr_file() {
if [ ""$1"" -ne ""0"" ]; then
echo ""$2 (return code $1): $(cat $STDERR_FILE)"" | logger -t user-data -s 2>/dev/console
fi
}

##########
# actually do the things we want to do
##########

####
# web server specific
apt-get -y install nginx
service nginx start

#####
# Ubuntu-specific first section just to install awscli
# need to use pip version since Ubuntu distro is too old
####
apt-get update
apt-get -y install python-pip
pip install awscli

#####
# custom code to set up users based on information extracted from S3
# run early so we can log in while waiting for the software installs
#####
echo ""%sudo ALL=(ALL) NOPASSWD:ALL"" >> /etc/sudoers

declare -a useradd_commands
declare -A key_file_s3_paths

# this loops through USER_CSV_S3_URL; see process substitution at done
while IFS= read -r line; do
if [[ $line =~ ^# ]]; then continue; fi
line=$(echo $line | sed 's/""//g') # remove double quotes
line=$(echo $line | sed ""s/'//g"") # remove single quotes
if [[ $line =~ $EXTRACTION_REGEX ]]; then
username=$${BASH_REMATCH[1]}
comment=$${BASH_REMATCH[2]}
shell=$${BASH_REMATCH[3]}
sudo_boolean=$${BASH_REMATCH[4]}
key_file=$${BASH_REMATCH[5]}
if [[ $sudo_boolean == ""true"" ]]; then
useradd_commands+=(""$USERADD -G $SUDO_GROUP -s $shell -c \""$comment\"" -m $username"")
else
useradd_commands+=(""$USERADD -s $shell -c \""$comment\"" -m $username"")
fi
key_file_s3_paths[$username]=""s3://$USER_S3_BUCKET/$USER_S3_SSH_KEYS_PREFIX$key_file""
else
log ""could not parse line in users list: $line""
fi
done < <(aws s3 cp $USER_CSV_S3_URL -)

# create users
for ((i = 0; i < $${#useradd_commands[@]}; i++)); do
log ""Creating user with command: $${useradd_commands[$i]}""
eval $${useradd_commands[$i]} 2>$STDERR_FILE
log_if_error_with_stderr_file $? ""User creation failed""
done

# install authorized_keys files
for username in ""$${!key_file_s3_paths[@]}""; do
s3_path=""$${key_file_s3_paths[$username]}""
ssh_dir=""/home/$username/.ssh/""
authkeys_path=""$ssh_dir/authorized_keys""
log ""Installing authorized_keys file for $username from $s3_path""
mkdir -p $ssh_dir
chmod 700 $ssh_dir
eval aws s3 cp $s3_path $authkeys_path 2>$STDERR_FILE
log_if_error_with_stderr_file $? ""Retrieval of authorized_keys failed""
chmod 600 $authkeys_path
chown -R $username:$username $ssh_dir
done

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


