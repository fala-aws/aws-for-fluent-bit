#!/bin/bash

bucket=$1
interval=$2
paths=$3

# Parse paths argument into array of items
IFS=',' read -ra items <<< "$paths"

# S3 uploader
s3_uploader.sh $bucket /s3_upload $interval &
pid1=$!

# Fluent Bit
(/fluent-bit/bin/fluent-bit -c /fluent-bit/etc/fluent-bit.conf; echo "\nwaiting 2 minutes for coredump to upload\n"; sleep 120; echo "exiting") &
pid2=$!

# All monitored log directories
# Loop over array items and run magic mirror
for item in "${items[@]}"; do
  echo "starting magic mirror from $item to /s3_upload$item"
  magic_mirror.sh "$item" /s3_upload$item -1 &
  pid4=$!
  pids=( "${pids[@]}" "$pid4" )
done

# Wait for any of the commands to finish
wait $pid1 $pid2 "${pids[@]}"

# Check exit status of commands
echo "One of the commands finished, stopping all commands."

# Kill all remaining commands
kill $pid1 $pid2 "${pids[@]}"
exit 1
