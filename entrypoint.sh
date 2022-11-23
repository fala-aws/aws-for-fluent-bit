echo -n "AWS for Fluent Bit Container Image Version "
cat /AWS_FOR_FLUENT_BIT_VERSION
export RAND=data-r3-1_9_10-keepalive-off-rand-$(($RANDOM%99999))$(($RANDOM%99999))$(($RANDOM%99999))
exec /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf
