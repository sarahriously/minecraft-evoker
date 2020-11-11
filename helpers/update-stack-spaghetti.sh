#!/bin/bash -x
DIRECTORY="$( dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"

aws cloudformation update-stack --stack-name spaghetti2 --template-body file://${DIRECTORY}/cfn/cfn.template.json --parameters file://${DIRECTORY}/parameters_spaghetti.json --capabilities CAPABILITY_IAM
