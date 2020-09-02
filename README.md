# Python SAM template that uses GitHub actions for CI\CD

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

To learn about secrets in GitHub see the [instructions](https://docs.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets-for-a-repository).

![GitHub Secrets](https://raw.githubusercontent.com/nirmash/python-sam-template/master/github-secrets.jpg)

Save the git repository URL, it is the URL of the repository you just created and configured with followed by `.git`. The format looks like: 
```shell
https://github.com/<user name>/<repo name>.git
```

### Push the code to GitHub
Once the secrets are configured, it is time to push code to GitHub. Back in the terminal type the below: 
```bash
$ git remote add origin https://github.com/<user name>/<repo name>.git
$ git branch -M master
$ git push -u origin master
```
You should see the output below: 
```bash
Counting objects: 11, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (11/11), 1.89 KiB | 484.00 KiB/s, done.
Total 11 (delta 0), reused 0 (delta 0)
To https://github.com/nirmash/MyLambdaFunc.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```

## Verify and test
To make sure the GitHub Action executed correctly, browse over to GitHub to the repository you just created. It takes about 2 minutes to deploy. 
![GitHub Action](https://raw.githubusercontent.com/nirmash/python-sam-template/master/github-workflow.jpg)
Copy the `arn` for the function (marked in the image above). Note that the function expects a JSON payload that includes an `obj_name` and `body` elements. 
You can test your function in the AWS console or in the terminal using the AWS cli as shown below:

```shell
aws lambda invoke \
    --function-name <your function arn> \
    --invocation-type RequestResponse \
    --payload '{ "obj_name": "Bob", "body" : "brr" }' \
    --cli-binary-format raw-in-base64-out \
    response.json
```
The response from the function should look like:

```shell
{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}
```
The function response is saved into the `response.json` file. To see the content of the file, type:
```shell
$ cat response.json
{"message": "Hello Bob brr!"}
```
Moving forward, any change you make to your repository and push to the master branch in GitHub will be redeployed to AWS. You can add more components to your AWS application by changing the `template.yaml` file (more information [here](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-specification-template-anatomy.html)). You can add more CI\CD rules by changing the `deploy.yml` file located under the `.github/workflows` folder in your repository (more information [here](https://docs.github.com/en/actions))
