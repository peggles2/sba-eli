#!/usr/bin/env bash
set -ex

echo 'export TAG=$(echo $CIRCLE_SHA1 | head -c 8)'  >> $BASH_ENV
echo 'export BRANCH=$(echo $CIRCLE_BRANCH | sed -r 's/[_]+/-/g')' >> $BASH_ENV
echo 'export DATE=$(date '+%Y-%m-%d')' >> $BASH_ENV

source $BASH_ENV

#Create Cluster
aws ecs create-cluster --cluster "${BRANCH}"

ecs-cli compose --project-name $BRANCH --ecs-params config/ecs-params.yml \
  --file docker-compose-aws.yml service up --launch-type FARGATE --create-log-groups \
  --cluster $BRANCH --timeout 15

ECS_IP=$(ecs-cli ps --cluster $BRANCH | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -n 1)
echo $ECS_IP

# Create DNS Record
cat > change-batch.json << EOF
 {
   "Comment": "change batch request on ${DATE}",
   "Changes": [
     {
       "Action": "CREATE",
       "ResourceRecordSet": {
         "Name": "${BRANCH}.${DOMAIN}",
         "Type": "A",
         "TTL": 60,
         "ResourceRecords": [
           {
             "Value":"${ECS_IP}"
           }
         ]
       }
     }
   ]
 }
EOF

aws route53 change-resource-record-sets --hosted-zone-id ${HOSTED_ZONE_ID} \
  --change-batch file://change-batch.json

sleep 60
