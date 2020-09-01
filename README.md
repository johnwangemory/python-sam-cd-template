# Python SAM template that uses GitHub actions for CI\C

This is a [Cookiecutter](https://github.com/audreyr/cookiecutter) template to create a Serverless App based on Serverless Application Model (SAM).

It is important to note that you should not try to `git clone` this project but use the instructions below to create a new Lambda Function with this template. 

## What it does

This template will setup a project that includes a "Hello World" Python 3.8 Lambda function and a [GitHub action](https://github.com/features/actions) that updates the function in AWS once a `git push` event happens in the resulting repository. The files generated after using the templates are:

```bash
.
{{ cookiecutter.project_name }}
├── {{ cookiecutter.project_name }}
│   └── __init__.py
│   └── app.py
│   └── requirements.txt
├── cmd.sh
├── template.yaml
```

The SAM template also creates an S3 bucket to store the function code. The `cmd.sh` file is used by the GitHub Action to deploy and redeploy the Lambda function.

## Requirements
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) already configured with Administrator permission 
* SAM CLI - [Install the SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
* [Docker installed](https://www.docker.com/community-edition) this is optional unless you wish to test your function locally
* [Python3.8.x](https://www.python.org/downloads/)


## Setup 
1. Run the SAM deployment as usual 
2. Execute the setup.sh
3. Do a SAM package
4. Push to github
5. Setup the secrets 
6. Make a change and push again
7. Try the function

## How to use


## Test
```shell
aws lambda invoke \
    --function-name arn:aws:lambda:us-west-2:070336696256:function:sammi-sammi1-1DHG9OPY40OMN \
    --invocation-type RequestResponse \
    --payload '{ "obj_name": "Bob", "body" : "brr" }' \
    --cli-binary-format raw-in-base64-out \
    response.json
```
