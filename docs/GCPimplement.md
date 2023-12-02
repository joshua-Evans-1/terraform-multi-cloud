GCP Implementation
==================


## Terraform
inside our [main.tf](../terraform/main.tf) file we need to specify our provider and define a module for GCP.

provider specification
```tf main.tf
provider "google" {
    version = "~> 3.38"
}
```
module definition

```tf main.tf
module "gcp_cloud" {
    source                 = "./modules/gcp"
}
