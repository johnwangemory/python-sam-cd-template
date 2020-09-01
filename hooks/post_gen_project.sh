#!/bin/sh
mkdir .github
mkdir .github/workflows
curl https://config-helpers.s3-us-west-2.amazonaws.com/deploy.yml?versionId=null > .github/workflows/deploy.yml
aws s3 mb s3://bucket-{{ cookiecutter.project_name }} --region "{{ cookiecutter.aws_region }}"
echo "Template ready"