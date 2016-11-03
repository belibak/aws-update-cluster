#!/bin/bash
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names " Dop-web-autoscale" | grep InstanceId | cut -d \" -f4 > instances
ARR=($(cat instances))

echo ${#ARR[@]}
echo "Running instances  - ${ARR[*]}"

echo "Terminating ${ARR[0]} ..."

aws ec2 terminate-instances --instance-ids ${ARR[0]}

unset ARR[0]

RUNNING=($(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" | grep \"InstanceId\" | cut -d \" -f 4))
RC=${#RUNNING[@]}

for i in {1..300} 
do
	RUNNING1=($(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" | grep \"InstanceId\" | cut -d \" -f 4))
	RC1=${#RUNNING1[@]}
	#echo "$RC $RC1"
	if [ $RC1 -gt $RC ]
		then
		
		echo "Waiting for instance run..." 
		sleep 120
		echo "Removing remaning instances - ${ARR[*]}"
		aws ec2 terminate-instances --instance-ids ${ARR[*]}
		 break
		else
		 echo "Wait until the instance starts - 10 seconds... "
		 sleep 10
	fi
done;

