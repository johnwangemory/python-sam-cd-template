# Python SAM template that uses GitHub actions for CI\C

This is a [Cookiecutter](https://github.com/audreyr/cookiecutter) template to create a Serverless App based on Serverless Application Model (SAM).

It is important to note that you should not try to `git clone` this project but use the instructions below to create a new Lambda Function with this template. 

## What it does

This template will setup a project that includes a "Hello World" Python 3.8 Lambda function and a [GitHub action](https://github.com/features/actions) that updates the function in AWS once a `git push` event happens in the resulting repository. The files generated after using the templates are:

```bash
.
{{ cookiecutter.project_name }}
├── .github                             <--- Folder for github CI\CD workflow
│   └── workflows
│      └── deploy.yml                   <--- GitHub action instructions that runs upon a push to the master branch
├── {{ cookiecutter.project_name }}     <--- Folder for the Lambda function code
│   └── __init__.py
│   └── app.py                          <--- "boilerplate" function code
│   └── requirements.txt                
├── cmd.sh                              <--- file executed by the GitHub Action workflow when a push to master happens
├── template.yaml                       <--- SAM instructions for setting up and updating the function    
```

## Requirements
* [git](https://git-scm.com/downloads) installed
* [GitHub](https://github.com) account
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) already configured with Administrator permission 
* SAM CLI - [Install the SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
* [Docker installed](https://www.docker.com/community-edition) this is optional unless you wish to test your function locally
* [Python3.8.x](https://www.python.org/downloads/)

## Setup 
### Use the SAM template to create a new Lambda function
Make sure you use the same AWS access keys to run this command as you would use to deploy your function. To understand and create an access key check out this [link](https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/).
In a terminal window, type:
```bash
$ sam init --location https://github.com/nirmash/python-sam-template.git
```
Follow the instructions as they appear (example below).
```bash
project_name [Project Name]: <project name>     <-- project folder name of your project and the CloudFormation stack in AWS
function_name [Function Name]: <function name>  <-- your Lambda function name 
aws_region [AWS Region]: <AWS region>           <-- AWS [region code](https://docs.aws.amazon.com/general/latest/gr/rande.html#regional-endpoints) for your function 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   515  100   515    0     0   2181      0 --:--:-- --:--:-- --:--:--  2182
make_bucket: bucket-<project name>              <-- The bucket for the function code
Template ready
```
**Note:**The setup script is using `curl` to download the GitHub Action workflow `yaml` file under the `.github/workflows` folder.

### Create your local git repository
Setup a local repository to be pushed to GitHub later by typing the below commands
```shell
$ git init
$ git add .
$ git commit . -m "Initial Commit"
```
### Setup and configure your remote repository
Create a [new GitHub repository](https://docs.github.com/en/enterprise/2.15/user/articles/create-a-repo), it doesn't matter whether it is Public or Private.

Add your AWS keys to your GitHub repository by configuring 2 new secrets, AWS_ACCESS_KEY_ID and AWS_ACCESS_KEY_ID. To obtain them on a MacOS you can use the below terminal commands.
```shell
$ cat ~/.aws/credentials
```
In the [AWS console](http://console.aws.amazon.com), use the below steps: 
* Click on your username near the top right and select **My Security Credentials**
* Click on **Users** in the sidebar
* Click on your username
* Click on the **Security Credentials** tab
* Click **Create Access Key**
* Click **Show User Security Credentials**

To learn about secrets in GitHub see the [instructions](https://docs.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets-for-a-repository)).




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
