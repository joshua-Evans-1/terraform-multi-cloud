# Terraform Multi-Cloud Networking (SDN)


# Prerequisites

FYI, we are all using Macs.

#### Local Install
* [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

#### Cloud provider cccounts
We created fresh cloud accounts to use for this project.
* AWS
* GCP


#### Set Up IAM User in AWS Account - Multi-Dev Setup
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
12. Download .csv of your access key. Keep safe as you can't download it again

#### Setup AWS CLI (local machine)
* terminal:  `$ which aws` to check for previous install
* [install instructions](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
* import your access keys .csv into AWS CLI
    * [instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html#cli-authentication-user-configure-csv)
     * csv import instructions don't work unless you manually add User Name column to front of csv as such: (or there are alt instructions at the linked page)
        ```
        User Name,Access key ID,Secret access key
        name_aws_tf,xxxxxxxxx,xxxxxxxxxxx
        ```


#### Set Up Google Cloud Project (one time only)
1. click on the project tab 
2. select create new project
3. name it and click create
4. search for 'Cloud Resource Manager API'. enable it

#### Service Account in GCP - Multi-Dev Setup
1. go to [google cloud console](https://console.cloud.google.com/)
2. select project
3. select service accounts unde the iam and admin tab
3. click create new service account 
    * for the service account name (`yourname_gcp_tf`) don't touch anything else. click create
4. you will see the user created and click actions on that user
5. from the dropdown click manage keys
6. click add key then create key and choose json
7. key will automatically download, keep in a safe place


#### Initalize Terraform in Workspace Directory (local machine)
tutorial say to go to git repo directory and do 
```
$ terraform init
```

It doesn't work!!!!
```
Terraform initialized in an empty directory!

The directory has no Terraform configuration files. You may begin working
with Terraform immediately by creating Terraform configuration files.
```



--------------------------
## TODO

1. Everyone download Terraform (TF) to their local machines

3. Create shared [github repo](https://github.com/joshua-Evans-1/terraform-multi-cloud) for the project

1. Learn how to use TF to provision infrastructure for one cloud.

3. Create shared AWS account for project. Share credentials.

3. [Figure out how to provision it via terraform and launch a service on this cloud.](https://developer.hashicorp.com/terraform/intro) 

4. Write out steps/ procedure in README file as we go. This will be part of our deliverable

6. Do step 3 for the other cloud - GCP or Azure

8. Figure out how to connect them and document the steps.
