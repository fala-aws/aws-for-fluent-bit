# To build run
```
make debug-s3
```

# To build quickly run
```
make debug-s3-quick
```

Here is the output image:
```
amazon/aws-for-fluent-bit:debug-s3
```

# To test this locally, please run
```
docker run -d --privileged --ulimit core=-1 -v `pwd`/output-containerjet/coredumps:/cores -v `pwd`/output-containerjet/out:/app/output --env-file="./.dockerenv" amazon/firelens-datajet:executor-latest
```
```
docker run -it --privileged --ulimit core=-1 -v /fake_apache_logs:/logs_mount/apache --env BUCKET=test-s3-instrumentation --env PATHS=/logs_mount/apache amazon/aws-for-fluent-bit:debug-s3
```


# Further testing shows that the --privileged option is not needed
```
docker run -it -v /tmp/fake_apache_logs:/logs_mount/apache --env BUCKET=test-s3-instrumentation --env PATHS=/logs_mount/apache amazon/aws-for-fluent-bit:debug-s3
```

test-s3-instrumentation