# Helm

variable "helm_chart_version" {
  type        = string
  default     = "1.12.6"
  description = "Version of the Helm chart"
}

variable "helm_repo_url" {
  type        = string
  default     = "https://istio-release.storage.googleapis.com/charts"
  description = "Helm repository"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "Have helm_resource create the namespace, default true"
}

variable "force_update" {
  type        = bool
  default     = false
  description = "(Optional) Force resource update through delete/recreate if needed. Defaults to false"
}

variable "recreate_pods" {
  type        = bool
  default     = false
  description = "(Optional) Perform pods restart during upgrade/rollback. Defaults to false."
}

# K8s

variable "cluster_name" {
  description = "k8s cluster name, required"
}

variable "k8s_namespace" {
  type        = string
  default     = "istio-system"
  description = "The K8s namespace in which to install the Helm chart, default: 'istio-system'"
}

variable "istio_base_settings" {
  type        = map(any)
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values, yamldecode will be performed on the HCL"
}

variable "istiod_settings" {
  type        = map(any)
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values, yamldecode will be performed on the HCL"
}

variable "istio_private_gateway_settings" {
  type        = map(any)
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values, yamldecode will be performed on the HCL"
}

variable "ca_private_key" {
  description = "the aws secret arn to use for ca_private_key, required"
  default     = ""
}

variable "ca_cert_chain" {
  description = "the aws secret arn to use for the ca_cert_chain, required"
  default     = ""
}

variable "ca_cert" {
  description = "the aws secret arn to use for the ca_cert, required"
  default     = ""
}

variable "subnets" {
  description = "provide the subnets used by load balancer for istio gateway"
  default     = []
}

variable "elb_load_balancer" {
  default = {
    "service" = {
      "annotations" = {
        "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
      },
      "ports" = [
        {
          "name"       = "https"
          "port"       = 443
          "protocol"   = "TCP"
          "targetPort" = 443
        },
        {
          "name"       = "http2"
          "port"       = 80
          "protocol"   = "TCP"
          "targetPort" = 80
        },
        {
          "name"       = "status-port"
          "port"       = 15021
          "protocol"   = "TCP"
          "targetPort" = 15021
        },
        {
          "name"       = "grpc"
          "port"       = 50051
          "protocol"   = "TCP"
          "targetPort" = 50051
        },
        {
          "name"       = "tls"
          "port"       = 15443
          "protocol"   = "TCP"
          "targetPort" = 15443
        },
      ]
    }
  }
}

variable "nlb_load_balancer" {
  default = {
    "service" = {
      "annotations" = {
        "service.beta.kubernetes.io/aws-load-balancer-type"     = "nlb"
        "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
      },
      "ports" = [
        {
          "name"       = "https"
          "port"       = 443
          "protocol"   = "TCP"
          "targetPort" = 443
        },
        {
          "name"       = "http2"
          "port"       = 80
          "protocol"   = "TCP"
          "targetPort" = 80
        },
        {
          "name"       = "status-port"
          "port"       = 15021
          "protocol"   = "TCP"
          "targetPort" = 15021
        },
        {
          "name"       = "grpc"
          "port"       = 50051
          "protocol"   = "TCP"
          "targetPort" = 50051
        },
        {
          "name"       = "tls"
          "port"       = 15443
          "protocol"   = "TCP"
          "targetPort" = 15443
        },
      ]
    }
  }
}

variable "istio_aws_elb_gw_enabled" {
  description = "enable or disable the istio gw install that has an ELB for load balancer, default true"
  default     = false
}

variable "istio_aws_nlb_gw_enabled" {
  description = "enable or disable the istio gw install that has an ELB for load balancer, default true"
  default     = false
}

variable "istio_meshconfig_network" {
  description = "Istio telementry network name, default network1"
  default     = "network1"
}

variable "istio_meshconfig_mesh_name" {
  description = "Istio telementry mesh name, default mesh1"
  default     = "mesh1"
}

variable "enable_aws_secret_manager_based_certs" {
  description = "If you would like to provide your own mTLS CA certs for istio to use, enable this flag and input AWS secret ARNs required"
  default     = false
}
