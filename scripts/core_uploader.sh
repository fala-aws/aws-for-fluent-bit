# Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
# 	http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

ls /cores-out/core*

# Process crash symbols
export CORE_FILENAME=`basename $S3_KEY_PREFIX`_`date +"%FT%H%M%S"`${HOSTNAME+_host-$HOSTNAME}_${RANDOM_ID_VALUE}
mv `ls /cores-out/core*` ${CORE_FILENAME}.core
cp /fluent-bit/bin/fluent-bit ./${CORE_FILENAME}.executable
gdb -batch -ex 'thread apply all bt full' -ex 'quit' '/fluent-bit/bin/fluent-bit' ${CORE_FILENAME}.core > /cores-out/${CORE_FILENAME}.stacktrace
zip -r /cores-out/${CORE_FILENAME}.all.zip /cores-out
mv /${CORE_FILENAME}.all.zip /cores-out/${CORE_FILENAME}.all.zip
zip /cores-out/${CORE_FILENAME}.core.zip /cores-out/${CORE_FILENAME}.core
rm /cores-out/${CORE_FILENAME}.core

# Send crash files to the /cores/ folder
cp /cores-out/* /cores/

# Send crash files to S3
aws s3 cp /cores-out s3://${S3_BUCKET}/${S3_KEY_PREFIX}/ --recursive

# Log stacktrace
echo "Stacktrace - ${CORE_FILENAME}.stacktrace:"
cat /cores/${CORE_FILENAME}.stacktrace
