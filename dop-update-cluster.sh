#!/bin/bash
devInstance="i-b828d764"
imageNum=$(date +%y%m%d-%k%M%S) #$(cat image-num)
keyName="white_dop"
autoScalingGroup=" Dop-web-autoscale"
instanceType="t2.medium"

echo "Creating AMI image ..."

aws ec2 create-image --name Dop-dev-"$imageNum" --instance-id $devInstance --no-reboot | cut -d \" -f 4 | grep ami > image-id

echo "$(($imageNum+1))"  > image-num

amiId=$(cat image-id)

echo "AMI image id: $amiId"
echo "Creating Autoscaling load configuration ... "

LCN="Dop-load-config-$imageNum"

aws autoscaling create-launch-configuration --launch-configuration-name "$LCN" --image-id "$amiId" --security-groups "sg-a71f7fde" --instance-type "$instanceType" --key-name="$keyName" 

echo "Updating Autoscaling group..."

aws autoscaling update-auto-scaling-group --auto-scaling-group-name "$autoScalingGroup" --launch-configuration-name "$LCN"

COUNTER=0
  
while [  $COUNTER -lt 60 ]; do         
  amiState=$(aws ec2 describe-images --image-ids "$amiId" | grep State | cut -d \" -f 4)
  if [ $amiState == "available" ]
    then 
      echo "$amiId $amiState"
      break 
    else       
      echo "$amiId $amiState wait 10 seconds..."
      sleep 10
  fi
  let COUNTER=COUNTER+1 
done
./dop-del-old.sh
