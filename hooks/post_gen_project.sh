#!/bin/sh

project_name = '{{ cookiecutter.project_name }}'
function_name = '{{ cookiecutter.function_name }}'
aws_region = '{{ cookiecutter.aws_region }}'

echo $project_name
echo $function_name
echo $aws_region

mkdir .github
mkdir .github/workflows
curl https://config-helpers.s3-us-west-2.amazonaws.com/deploy.yml > .github/workflows/deploy.yml
echo "Template ready"