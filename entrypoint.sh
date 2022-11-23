echo -n "AWS for Fluent Bit Container Image Version "
cat /AWS_FOR_FLUENT_BIT_VERSION
export RAND=data-r2-1.9-keepalive-on-t4-control-27b9f6be6530dedffb93a125a07252a3dc1a242f-rand-$(($RANDOM%99999))$(($RANDOM%99999))$(($RANDOM%99999))
exec /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf
