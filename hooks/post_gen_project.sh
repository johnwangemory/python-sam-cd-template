#!/bin/sh
mkdir .github
mkdir .github/workflows
curl https://config-helpers.s3-us-west-2.amazonaws.com/deploy.yml?versionId=null > .github/workflows/deploy.yml
cd {{ cookiecutter.project_name }}
echo "Template ready"