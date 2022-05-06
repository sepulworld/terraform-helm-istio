provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {}

provider "aws" {
  skip_credentials_validation = true
}
