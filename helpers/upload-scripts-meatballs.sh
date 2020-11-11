#!/bin/bash -x
DIRECTORY="$( dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
BUCKET=meta-meatballs-bucket
aws s3 cp ${DIRECTORY}/scripts/ s3://${BUCKET}/common/scripts --recursive
