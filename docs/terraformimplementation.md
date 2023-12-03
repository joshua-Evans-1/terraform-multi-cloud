# teraform implementation

## working directory
to start our project in terraform we are going to create a working directory we named it terraform but you can name it whatever you like 
```sh
mkdir <directory_name>
```

## files

we need to create a few files inside our working directory in order to init our terraform environment 
```sh
touch main.tf outputs.tf terraform.tfvars variables.tf
``` 
### main.tf
[main.tf](../terraform/main.tf) will contain the main set of configuration for the project. 
```tf main.tf
terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 4.51.0"
        }
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.29.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
    profile = var.aws_iAM
}


provider "google" {
    region      = var.gcp_region_name
    credentials = file(var.gcp_cred_file)
    project     = var.gcp_project_id
}
```

### outputs.tf 
[outputs.tf](../terraform/outputs.tf) will contain the output definitions for the project.
### terraform.tfvars
[terraform.tfvars](../terraform/terraform.tfvars) will contain the variable assignments for the project.

### variables.tf
[variables.tf](../terraform/variables.tf) will contain the variable definitions for the project.

## modules
terraform modules can be used to create more complex and organized  configurations inside terraform
we will create a modules folder inside our working directory we made earlier
```sh
mkdir <terraform_directory>/modules
```
see other implementation documents for specific implementation of modules