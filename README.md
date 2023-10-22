# Terraform Multi-Cloud Networking(SDN)

## Terraform Installation

### MacOS
[AARCH64 M1 Download ](https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_darwin_arm64.zip)

[Intel Download](https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_darwin_amd64.zip)

or
```MacOS

brew tap hashicorp/tap

brew install hashicorp/tap/terraform

```

### Linux
```Linux

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform

```
### Windows
[Download Link](https://releases.hashicorp.com/terraform/1.6.2/terraform_1.6.2_windows_amd64.zip)


## TODO

1. Everyone download Terraform (TF) to their local machines

3. Create shared [github repo](https://github.com/joshua-Evans-1/terraform-multi-cloud) for the project

1. Learn how to use TF to provision infrastructure for one cloud.

3. Create shared AWS account for project. Share credentials.

3. [Figure out how to provision it via terraform and launch a service on this cloud.](https://developer.hashicorp.com/terraform/intro) 

4. Write out steps/ procedure in README file as we go. This will be part of our deliverable

6. Do step 3 for the other cloud - GCP or Azure

8. Figure out how to connect them and document the steps.
