#!/bin/bash -x
DIRECTORY="$( dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"
DEFAULT_STACK_NAME=spaghetti
aws cloudformation create-stack --stack-name meatballs --template-body file://${DIRECTORY}/cfn/s3.template.json --parameters file://${DIRECTORY}/parameters_meatballs.json --capabilities CAPABILITY_IAM
