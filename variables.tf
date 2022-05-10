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

variable "enable_aws_secret_manager_based_certs" {
  description = "If you would like to provide your own mTLS CA certs for istio to use, enable this flag and input AWS secret ARNs required"
  default     = false
}

// Istiod chart values
variable "istiod_global_network" {
  description = "Istio telementry network name, default network1"
  default     = "network1"
}

variable "istiod_global_meshID" {
  description = "Istio telementry mesh name, default mesh1"
  default     = "mesh1"
}


variable "istiod_meshConfig_defaultConfig_envoyMetricsService_address" {
  description = "The mesh default config envoy metrics service address"
  default     = "gloo-mesh-agent.gloo-mesh:9977"
}

variable "istiod_meshConfig_accessLogFile" {
  description = "The mesh config access log file"
  default     = "/dev/stdout"
}

variable "istiod_meshConfig_rootNamespace" {
  description = "The mesh config root namespace"
  default     = "istio-system"
}

variable "istiod_meshConfig_enableAutoMtls" {
  description = "The mesh config enable automtls, default 'true'"
  default     = "true"
}

variable "istiod_meshConfig_defaultConfig_envoyAccessLogService_address" {
  description = "The mesh default config envoy access log service address"
  default     = "gloo-mesh-agent.gloo-mesh:9977"
}

variable "istiod_meshConfig_defaultConfig_proxyMetadata_IstioMetaDNSCapture" {
  type        = string
  description = "The mesh config default for ISTIO_META_DNS_CAPTURE, enable or disable, default 'true'"
  default     = "true"
}

variable "istiod_meshConfig_defaultConfig_proxyMetadata_IstioMetaDNSAutoAllocate" {
  type        = string
  description = "The mesh config default for ISTIO_META_DNS_AUTO_ALLOCATE, enable or disable, default 'true'"
  default     = "true"
}

variable "istiod_pilot_env_PilotSkipValidateTrustDomain" {
  type        = string
  description = "Pilot skip validate trust domain flag, default 'true'"
  default     = "true"
}
