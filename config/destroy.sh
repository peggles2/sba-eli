#!/usr/bin/env bash
set -ex

BRANCH=$(echo ${CIRCLE_BRANCH} | sed -r 's/[_]+/-/g')
IP=$(ecs-cli ps --cluster ${BRANCH} | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -n 1)

# Delete DNS Record
cat > change-batch.json << EOF
{
  "Comment": "change batch request on ${DATE}",
  "Changes": [
    {
      "Action": "DELETE",
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

# echo "Deleting DNS Record set..."
aws route53 change-resource-record-sets --hosted-zone-id ${HOSTED_ZONE_ID} --change-batch file://change-batch.json

echo "Destroying Fargate Service..."
ecs-cli compose --file docker-compose-aws.yml --project-name ${BRANCH} service rm --cluster ${BRANCH}

echo "Destroying cluster..."
aws ecs delete-cluster --cluster ${BRANCH}

echo "Operation Completed."
