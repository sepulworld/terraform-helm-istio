provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {}

provider "aws" {
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_get_ec2_platforms = true
  skip_metadata_api_check = true
  skip_requesting_account_id = true
  skip_region_validation = true
}
