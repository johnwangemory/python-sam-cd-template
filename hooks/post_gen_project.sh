#!/bin/sh
mkdir .github
mkdir .github/workflows
curl https://config-helpers.s3-us-west-2.amazonaws.com/deploy.yml?versionId=null > .github/workflows/deploy.yml
bucket="`{{ cookiecutter.project_name }} | tr 'A-Z' 'a-z'`"
aws s3 mb s3://bucket-$bucket --region "{{ cookiecutter.aws_region }}"
echo "Template ready"