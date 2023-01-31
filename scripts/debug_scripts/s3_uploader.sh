#!/bin/bash

bucket=$1
source=$2
interval=$3
echo "s3 uploader bucket=$bucket, interval=$interval, paths=$source"


while true; do
    sleep $interval
    echo "syncing s3 source: $source, bucket: s3://$bucket/"
    aws s3 sync $source s3://$bucket/
done