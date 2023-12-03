AWS Implementation
==================

## Terraform / AWS Authentication
During setup, you sould have already downloaded your AWS access keys (.csv) AND imported the key file into AWS CLI.

AWS CLI should keep your credentials in this file path: 
 `~/.aws/credentials`

If you have multiple AWS credentials, they are all stored in this fil, so if you peek inside, it might look something like this:
```
$ cat ~/.aws/credentials

[default]
aws_access_key_id = ...
aws_secret_access_key = ...
[yourname_aws_tf]
aws_access_key_id = ...
aws_secret_access_key = ...
```
Confirm that the credentials for your IAM User `yourname_aws_tf` are in this file

### Authentication
Authenticate by adding this line to the AWS provider configuration in [main.tf](../terraform/main.tf):
```
provider "aws" {
   ...
  profile = "yourname_aws_tf"
}
```
If your AWS credentials file is at different location than Terraform expects, also include this attribute:
```
provider "aws" {
   ...
  shared_credentials_files = ["path/to/file"]
}
```

### TODO: Fix harcoded profile name. technically we should not hardcode this in, since we all have different usernames.
but it works for the moment and doesn't expose the secret