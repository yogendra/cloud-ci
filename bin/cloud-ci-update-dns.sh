#!/bin/bash

FQDN=${1?"Missing FQDN"}

HOSTED_ZONE_ID=$(aws route53  list-hosted-zones-by-name --dns-name $FQDN --output text --query "HostedZones[0].Id" | sed s:/hostedzone/:: )
DNS_NAME=$(aws ec2 describe-instances --filters Name=tag:Name,Values=cloud-ci --output text --query "Reservations[].Instances[].PublicDnsName")
cat <<EOF >temp.json
{
  "Comment": "Creating Alias resource record sets in Route 53",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "$FQDN",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "$HOSTED_ZONE_ID",
          "DNSName": "$DNS_NAME",
          "EvaluateTargetHealth": false
        }
      }
    }
  ]
}
EOF
aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch file://temp.json
rm temp.json

