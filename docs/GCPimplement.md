GCP Implementation
==================


## terraform initialization
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
```
## GCP Module 

inside our [modules directory](../terraform/modules/) we create a directory named gcp.
```sh
mkdir /terraform/modules/gcp
```

## Files
inside our gcp module directory we create our files 

```sh 
touch network.tf output.tf vars.t
```
```tree
gcp
├── network.tf
├── output.tf
└── vars.tf
```
### network.tf

### output.tf

### vars.tf

