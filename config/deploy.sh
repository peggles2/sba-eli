#!/usr/bin/env bash
set -ex

echo 'export TAG=$(echo ${CIRCLE_SHA1} | head -c 8)' >> $BASH_ENV
echo 'export BRANCH=$(echo ${CIRCLE_BRANCH} | sed -r 's/[_]+/-/g')' >> $BASH_ENV
echo 'export DATE=$(date '+%Y-%m-%d')' >> $BASH_ENV

source $BASH_ENV

function createCluster() {
  aws ecs create-cluster --cluster ${BRANCH}
}

function createService() {
  ecs-cli compose --project-name ${BRANCH} --ecs-params config/ecs-params.yml \
    --file docker-compose-aws.yml service up --launch-type FARGATE --create-log-groups \
    --cluster ${BRANCH} --timeout 15
}


function updateDns() {

IP=$(ecs-cli ps --cluster ${BRANCH} | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -n 1)

cat > change-batch.json << EOF
 {
   "Comment": "change batch request on ${DATE}",
   "Changes": [
     {
       "Action": "UPSERT",
       "ResourceRecordSet": {
         "Name": "${BRANCH}.${DOMAIN}",
         "Type": "A",
         "TTL": 60,
         "ResourceRecords": [
           {
             "Value":"${IP}"
           }
         ]
       }
     }
   ]
 }
EOF

aws route53 change-resource-record-sets --hosted-zone-id ${HOSTED_ZONE_ID} \
  --change-batch file://change-batch.json
}

createCluster
createService
sleep 180
updateDns
