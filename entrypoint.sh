echo -n "AWS for Fluent Bit Container Image Version "
cat /AWS_FOR_FLUENT_BIT_VERSION
export DATA_STREAM_NAME=data-std-patch-20-workers
export RAND=$(($RANDOM%99999))$(($RANDOM%99999))$(($RANDOM%99999))
export N_WORKERS=20
exec /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf
