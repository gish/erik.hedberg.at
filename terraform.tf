variable "domain_name" {
  type = string
}

provider "aws" {
}

module "website" {
  source = "./.deploy/terraform/"
  domain_name = var.domain_name
}