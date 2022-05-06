locals {
  subnets = join("\\,", var.subnets)
}

resource "helm_release" "istio-base" {
  chart            = "base"
  namespace        = var.k8s_namespace
  create_namespace = var.create_namespace
  name             = "istio-base"
  version          = var.helm_chart_version
  repository       = var.helm_repo_url == "./helm" ? "${path.module}/helm" : var.helm_repo_url
  force_update     = var.force_update
  recreate_pods    = var.recreate_pods

  values = [
    yamlencode(var.istio_base_settings)
  ]
}

resource "helm_release" "istiod" {
  depends_on       = [helm_release.istio-base, kubernetes_secret.istio-ca]
  chart            = "istiod"
  namespace        = var.k8s_namespace
  create_namespace = var.create_namespace
  name             = "istiod"
  version          = var.helm_chart_version
  repository       = var.helm_repo_url == "./helm" ? "${path.module}/helm" : var.helm_repo_url
  force_update     = var.force_update
  recreate_pods    = var.recreate_pods

  set {
    name  = "global.meshID"
    value = var.istio_meshconfig_mesh_name
  }

  set {
    name  = "global.multiCluster.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "global.network"
    value = var.istio_meshconfig_network
  }

  set {
    name  = "meshConfig.rootNamespace"
    value = "istio-system"
  }

  set {
    name  = "meshConfig.trustDomain"
    value = var.cluster_name
  }

  set {
    name  = "meshConfig.accessLogFile"
    value = "/dev/stdout"
  }

  set {
    name  = "meshConfig.enableAutoMtls"
    value = "true"
  }

  set {
    name  = "meshConfig.defaultConfig.envoyMetricsService.address"
    value = "gloo-mesh-agent.gloo-mesh:9977"
  }

  set {
    name  = "meshConfig.defaultConfig.envoyAccessLogService.address"
    value = "gloo-mesh-agent.gloo-mesh:9977"
  }

  set {
    name  = "meshConfig.defaultConfig.proxyMetadata.ISTIO_META_DNS_CAPTURE"
    value = "true"
    type  = "string"
  }

  set {
    name  = "meshConfig.defaultConfig.proxyMetadata.ISTIO_META_DNS_AUTO_ALLOCATE"
    value = "true"
    type  = "string"
  }

  set {
    name  = "meshConfig.defaultConfig.proxyMetadata.GLOO_MESH_CLUSTER_NAME"
    value = var.cluster_name
    type  = "string"
  }

  set {
    name  = "pilot.env.PILOT_SKIP_VALIDATE_TRUST_DOMAIN"
    value = "true"
  }

  values = [
    yamlencode(var.istiod_settings)
  ]
}

resource "helm_release" "istio-gateway-aws-nlb" {
  // Optional AWS NLB based gateway
  count            = var.istio_aws_nlb_gw_enabled ? 1 : 0
  depends_on       = [helm_release.istio-base, helm_release.istiod]
  chart            = "gateway"
  namespace        = "istio-gateway"
  create_namespace = var.create_namespace
  name             = "istio-private-gateway-aws-nlb"
  version          = var.helm_chart_version
  repository       = var.helm_repo_url == "./helm" ? "${path.module}/helm" : var.helm_repo_url
  force_update     = var.force_update
  recreate_pods    = var.recreate_pods

  set {
    name  = "labels.istio"
    value = "private-gateway"
  }

  set {
    name  = "labels.topology\\.istio\\.io/network"
    value = var.istio_meshconfig_network
  }

  set {
    name  = "env.ISTIO_META_ROUTER_MODE"
    value = "sni-dnat"
  }

  set {
    name  = "env.ISTIO_META_REQUESTED_NETWORK_VIEW"
    value = var.istio_meshconfig_network
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"
    value = local.subnets
  }

  values = [
    yamlencode(merge(var.istio_private_gateway_settings, var.nlb_load_balancer))
  ]
}

resource "helm_release" "istio-gateway-aws-elb" {
  // Optional AWS ELB based gateway
  count            = var.istio_aws_elb_gw_enabled ? 1 : 0
  depends_on       = [helm_release.istio-base, helm_release.istiod]
  chart            = "gateway"
  namespace        = "istio-gateway"
  create_namespace = var.create_namespace
  name             = "istio-private-gateway-aws-elb"
  version          = var.helm_chart_version
  repository       = var.helm_repo_url == "./helm" ? "${path.module}/helm" : var.helm_repo_url
  force_update     = var.force_update
  recreate_pods    = var.recreate_pods

  set {
    name  = "labels.istio"
    value = "private-gateway-elb"
  }

  set {
    name  = "labels.topology\\.istio\\.io/network"
    value = var.istio_meshconfig_network
  }

  set {
    name  = "env.ISTIO_META_ROUTER_MODE"
    value = "sni-dnat"
  }

  set {
    name  = "env.ISTIO_META_REQUESTED_NETWORK_VIEW"
    value = var.istio_meshconfig_network
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-subnets"
    value = local.subnets
  }

  set {
    name  = "service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
    value = "true"
    type  = "string"
  }

  values = [
    yamlencode(merge(var.istio_private_gateway_settings, var.elb_load_balancer))
  ]
}

data "aws_secretsmanager_secret_version" "ca_private_key" {
  count     = var.enable_aws_secret_manager_based_certs ? 1 : 0
  secret_id = var.ca_private_key
}

data "aws_secretsmanager_secret_version" "ca_cert_chain" {
  count     = var.enable_aws_secret_manager_based_certs ? 1 : 0
  secret_id = var.ca_cert_chain
}

data "aws_secretsmanager_secret_version" "ca_cert" {
  count     = var.enable_aws_secret_manager_based_certs ? 1 : 0
  secret_id = var.ca_cert
}

resource "kubernetes_secret" "istio-ca" {
  count      = var.enable_aws_secret_manager_based_certs ? 1 : 0
  depends_on = [helm_release.istio-base]

  metadata {
    name      = "cacerts"
    namespace = "istio-system"
  }

  data = {
    "ca-cert.pem"    = data.aws_secretsmanager_secret_version.ca_cert[count.index].secret_string
    "cert-chain.pem" = data.aws_secretsmanager_secret_version.ca_cert[count.index].secret_string
    "ca-key.pem"     = data.aws_secretsmanager_secret_version.ca_private_key[count.index].secret_string
    "root-cert.pem"  = data.aws_secretsmanager_secret_version.ca_cert_chain[count.index].secret_string
  }
}
