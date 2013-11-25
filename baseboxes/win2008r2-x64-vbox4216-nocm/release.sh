# #!/bin/bash

# S3BaseLocation=s3://vagrant-windows
# BoxBaseName=${PWD##*/}
# BoxName=${BoxBaseName}.box

# s3cmd put $BoxName $S3BaseLocation/${BoxName}.upload --force
# s3cmd del $S3BaseLocation/$BoxName
# s3cmd mv $S3BaseLocation/${BoxName}.upload $S3BaseLocation/$BoxName
# sleep 1
# s3cmd setacl —-acl-public $S3BaseLocation/$BoxName
