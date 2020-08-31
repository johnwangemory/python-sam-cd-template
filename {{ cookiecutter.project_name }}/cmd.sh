sam deploy --stack-name "{{ cookiecutter.project_name }}" \
    --parameter-overrides "ParameterKey=project_name,ParameterValue={{ cookiecutter.project_name }},ParameterKey=aws_region,ParameterValue={{ cookiecutter.aws_region }},ParameterKey=function_name,ParameterValue={{ cookiecutter.function_name }}" \ 
    --s3-bucket "bucket-{{ cookiecutter.project_name }}" \
    --s3_prefix = "{{ cookiecutter.project_name }}" \
    --region = "{{ cookiecutter.aws_region }}" \
    --confirm_changeset = false \
    --capabilities = "CAPABILITY_IAM"
