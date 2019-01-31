#!/usr/bin/env bash
set -eo pipefail

export TAG=$(echo $CIRCLE_SHA1 | head -c 8)
export BRANCH=$(echo $CIRCLE_BRANCH | sed -r 's/[_]+/-/g')
export DATE=$(date '+%Y-%m-%d')

#Create Cluster
aws ecs create-cluster --cluster "$BRANCH"

#Create Load Balancer
ELB_ARN=$(aws elbv2 create-load-balancer --name $BRANCH --subnets $PUBLIC_SUBNET_ONE \
  $PUBLIC_SUBNET_TWO --security-groups $LB_SECURITY_GROUP --scheme internet-facing \
  --type application | jq --raw-output --exit-status '.LoadBalancers[].LoadBalancerArn')

export ELB_DNS=$(aws elbv2 describe-load-balancers --load-balancer-arns $ELB_ARN | \
  jq  --raw-output --exit-status '.LoadBalancers[].DNSName')
echo "$ELB_DNS"

# Create Target Group
if TARGET_GROUP_ARN=$(aws elbv2 create-target-group --name $BRANCH --protocol HTTP \
  --port 80 --vpc-id $VPC --target-type ip | jq --raw-output --exit-status '.TargetGroups[].TargetGroupArn'); then
  echo "$TARGET_GROUP_ARN"
else
  echo "Failed to create target group"
fi

# Create Listener
if LISTENER_ARN=$(aws elbv2 create-listener --load-balancer-arn $ELB_ARN --protocol HTTP \
  --port 80 --default-actions Type=forward,TargetGroupArn=$TARGET_GROUP_ARN); then
  echo "$LISTENER_ARN"
else
  echo "Failed to create listener"
fi

# Create Service
ecs-cli compose --project-name $BRANCH --ecs-params config/ecs-params.yml \
  --file docker-compose-aws.yml service up --launch-type FARGATE --create-log-groups \
  --cluster $BRANCH --container-port 80 --container-name nginx \
  --health-check-grace-period 300 --target-group-arn $TARGET_GROUP_ARN --timeout 15

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
        "AliasTarget": {
          "HostedZoneId": "${HOSTED_ZONE_ID}",
          "DNSName": "${ELB_DNS}",
          "EvaluateTargetHealth": true
        }
      }
    }
  ]
}
EOF

aws route53 change-resource-record-sets --hosted-zone-id ${HOSTED_ZONE_ID} --change-batch file://change-batch.json

printf "Done, application is at: http://${BRANCH}.${DOMAIN}\n";
printf "(It may take a minute for the container to register as healthy and begin receiving traffic.)\n";
