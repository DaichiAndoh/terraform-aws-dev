terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  cloud {
    organization = "DaichiAndoh"

    workspaces {
      name = "dandoh-dev"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
