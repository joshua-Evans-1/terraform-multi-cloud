terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.5.0"
        }
        google = {
            source = "hashicorp/google"
            version = "~> 5.6.0"
        }
    }
}

provider "aws" {
    region = "us-east-2"
}
provider "google" {
  # Configuration options
}
