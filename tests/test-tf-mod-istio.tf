module "istio" {
  source                   = "../"
  cluster_name             = "test"
  istio_aws_elb_gw_enabled = false
  istio_aws_nlb_gw_enabled = false
}
