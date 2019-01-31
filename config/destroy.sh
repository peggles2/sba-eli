#!/usr/bin/env bash
set -eo pipefail

# Delete DNS Record
cat > change-batch.json << EOF
{
  "Comment": "change batch request on ${DATE}",
  "Changes": [
    {
      "Action": "DELETE",
      "ResourceRecordSet": {
        "Name": "${BRANCH}.${DOMAIN}",
        "Type": "CNAME",
        "TTL": 60,
        "ResourceRecords": [
          {
            "Value":"${ELB_DNS}"
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

echo "Destroying Load Balancer ..."
aws elbv2 delete-listener --listener-arn ${LISTENER_ARN}
aws elbv2 delete-target-group --target-group-arn ${TARGET_GROUP_ARN}
aws elbv2 delete-load-balancer --load-balancer-arn ${LB_ARN}
echo "Operation Completed."
