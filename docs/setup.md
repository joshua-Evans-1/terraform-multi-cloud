# Setup

Prerequisites
===============

#### Install locally
* [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* [gcloud](https://cloud.google.com/sdk/docs/install)  

#### Create cloud provider root cccounts
* Amazon Web Services (AWS)
* Google Cloud Project (GCP)



AWS
===

Set Up IAM User in AWS Account 
========================================
We created a 'devs' group w/ full admin access for each IAM user in the group. 
If you're working solo (professor?), just create a single accoount with full permissions.

1. log in as root user to [AWS console](https://aws.amazon.com/console/)
2. go to IAM (Identity and Access Management)   - *not* IAM Identity Center
3. click Users  (left sidebar)
4. click Create User  (button)
    * name yourself (`yourname_aws_tf`). don't touch anything else. click next
5. add yourself to 'devs' user group. click next
6. click Create User to finalize
7. click on your newly created username
8. go to 'Create access key'  (top right ish of screen)
    * FYI: [Access Key docs](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)
    * FYI: [Access Key best practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#securing_access-keys)
9. select use case: CLI, click through to next screen
10. name description tag: localmachine  (or something similar.. point is to identify it will be going on your computer)
11. click Create Access Key to finalize
12. Download .csv of your access key, keep in a safe place



Setup AWS CLI
=============
* terminal:   `$ which aws`   to check for previous install (old & new installs don't get along)
* [install instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* import your access keys .csv into AWS CLI
    * [instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html#cli-authentication-user-configure-csv)
     * csv import instructions don't work unless you manually add User Name column to front of csv as such: (or there are alt instructions at the linked page)
        ```
        User Name,Access key ID,Secret access key
        name_aws_tf,xxxxxxxxx,xxxxxxxxxxx
        ```

## Terraform / AWS Authentication
Now that you've added your credentials to AWS CLI, they should be i this file: 
 `~/.aws/credentials`

If you already had multiple AWS credentials, they are all stored in this file, so if you peek inside, it might look something like this:
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


Change the line in [terraform.tfvars](../terraform/terraform.tfvars#L10):

    ```tf
    aws_iAM                     = "<yourname>_aws_tf"
    aws_cred_file               = "~/.aws/credentials"
    ```

You do not need to update `aws_cred_file` unless it is stored somewhere other than the default.


GCP
===

Set Up Google Cloud Project
===========================
1. click on the project tab 
2. select create new project
3. name it and click create
4. search for 'Cloud Resource Manager API'. enable it

Service Account in GCP
======================
Repeat for all devs
1. go to [google cloud console](https://console.cloud.google.com/)
2. select project
3. select service accounts unde the iam and admin tab
3. click create new service account 
    * for the service account name (`yourname_gcp_tf`) don't touch anything else. click create
4. you will see the user created and click actions on that user
5. from the dropdown click manage keys
6. click add key then create key and choose json
7. key will automatically download keep in a safe place



gcloud setup
===========
1. run gcloud authentication command
    ```sh   
    gcloud auth application-default login  
    ```
    the command will prompt you to login using a browser
2. after authenticating in your browser it will return a credential file location
    
    something like
    ```sh
    Credentials saved to file: [/Users/<your user>/.config/gcloud/application_default_credentials.json]
    ```
3. change the line in [terraform.tfvars](../terraform/terraform.tfvars#L8)
    ```tf
    gcp_cred_file               = "/Users/<your_user>/.config/gcloud/application_default_credentials.json"
    ```
4. set the default working project
    ```sh
    gcloud config set project <project_id>
    ```
5. enable gcloud compute engine
    ```sh
    gcloud services enable compute.googleapis.com
    ```

terraform.tfvars
===========
Update [terraform.tfvars](../terraform/terraform.tfvars) with YOUR information that we obtained during the setup process.

```
## Google Cloud variable definitions
gcp_region_name             = "us-east1"
gcp_cred_file               = "~/.config/gcloud/application_default_credentials.json"
gcp_project_id              = "term-project-v2"
 ....
gcp_network_name            = "project"

## AWS variable definitions 
aws_region                  = "us-east-1"
aws_iAM                     = "annie_aws_tf"
aws_cred_file               = "~/.aws/credentials"
....

```

Some recommend to not git commit this file so as not to expose secrets. In this project we do not add any secrets to this file. (Local file paths to credentials are not secrets) 

However, be aware of this if you choose to add more variables to this file.