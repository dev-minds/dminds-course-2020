#!/usr/bin/env bash

# TOD DO: Use below sermVer to change version names 
# https://github.com/cloudflare/semver_bash/blob/master/semver_test.sh
#

DATE=$(date +%Y%m%d%H%M) 
AMI_NAME="LiveManagementNodeAmi.$DATE"
AMI_DESCRIPTION="Management Node Continous Backup - $DATE"
INSTANCE_ID=`/usr/local/bin/terraform show|grep "arn:aws:ec2:eu-west-1:658951324167:instance" | cut -d"/" -f2| tr -d '"'`

printf "Requesting AMI for instance $1...\n"
aws ec2 create-image --instance-id "$INSTANCE_ID" --name "$AMI_NAME" --description "$AMI_DESCRIPTION" --no-reboot

if [ $? -eq 0 ]; then
	printf "AMI request complete!\n"
fi

printf ""
printf ""
printf "Waiting for another 15mins before i destroy the environemnt"
sleep 60s
printf "........."
/usr/local/bin/terraform destroy -force 
