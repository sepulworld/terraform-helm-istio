## Module Name: terraform-helm-istio
#### Description: Install and setup Istio via Helm
#### [Terraform Registry Module](https://registry.terraform.io/modules/sepulworld/istio/helm/latest)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.istio-base](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.istiod](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret.istio-ca](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [aws_secretsmanager_secret_version.ca_cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.ca_cert_chain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.ca_private_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca_cert"></a> [ca\_cert](#input\_ca\_cert) | the aws secret arn to use for the ca\_cert, required | `string` | `""` | no |
| <a name="input_ca_cert_chain"></a> [ca\_cert\_chain](#input\_ca\_cert\_chain) | the aws secret arn to use for the ca\_cert\_chain, required | `string` | `""` | no |
| <a name="input_ca_private_key"></a> [ca\_private\_key](#input\_ca\_private\_key) | the aws secret arn to use for ca\_private\_key, required | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | k8s cluster name, required | `any` | n/a | yes |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Have helm\_resource create the namespace, default true | `bool` | `true` | no |
| <a name="input_enable_aws_secret_manager_based_certs"></a> [enable\_aws\_secret\_manager\_based\_certs](#input\_enable\_aws\_secret\_manager\_based\_certs) | If you would like to provide your own mTLS CA certs for istio to use, enable this flag and input AWS secret ARNs required | `bool` | `false` | no |
| <a name="input_force_update"></a> [force\_update](#input\_force\_update) | (Optional) Force resource update through delete/recreate if needed. Defaults to false | `bool` | `false` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Version of the Helm chart | `string` | `"1.12.6"` | no |
| <a name="input_helm_repo_url"></a> [helm\_repo\_url](#input\_helm\_repo\_url) | Helm repository | `string` | `"https://istio-release.storage.googleapis.com/charts"` | no |
| <a name="input_istio_base_settings"></a> [istio\_base\_settings](#input\_istio\_base\_settings) | Additional settings which will be passed to the Helm chart values, yamldecode will be performed on the HCL | `map(any)` | `{}` | no |
| <a name="input_istiod_global_meshID"></a> [istiod\_global\_meshID](#input\_istiod\_global\_meshID) | Istio telementry mesh name, default mesh1 | `string` | `"mesh1"` | no |
| <a name="input_istiod_global_network"></a> [istiod\_global\_network](#input\_istiod\_global\_network) | Istio telementry network name, default network1 | `string` | `"network1"` | no |
| <a name="input_istiod_meshConfig_accessLogFile"></a> [istiod\_meshConfig\_accessLogFile](#input\_istiod\_meshConfig\_accessLogFile) | The mesh config access log file | `string` | `"/dev/stdout"` | no |
| <a name="input_istiod_meshConfig_defaultConfig_envoyAccessLogService_address"></a> [istiod\_meshConfig\_defaultConfig\_envoyAccessLogService\_address](#input\_istiod\_meshConfig\_defaultConfig\_envoyAccessLogService\_address) | The mesh default config envoy access log service address | `string` | `"gloo-mesh-agent.gloo-mesh:9977"` | no |
| <a name="input_istiod_meshConfig_defaultConfig_envoyMetricsService_address"></a> [istiod\_meshConfig\_defaultConfig\_envoyMetricsService\_address](#input\_istiod\_meshConfig\_defaultConfig\_envoyMetricsService\_address) | The mesh default config envoy metrics service address | `string` | `"gloo-mesh-agent.gloo-mesh:9977"` | no |
| <a name="input_istiod_meshConfig_defaultConfig_proxyMetadata_IstioMetaDNSAutoAllocate"></a> [istiod\_meshConfig\_defaultConfig\_proxyMetadata\_IstioMetaDNSAutoAllocate](#input\_istiod\_meshConfig\_defaultConfig\_proxyMetadata\_IstioMetaDNSAutoAllocate) | The mesh config default for ISTIO\_META\_DNS\_AUTO\_ALLOCATE, enable or disable, default 'true' | `string` | `"true"` | no |
| <a name="input_istiod_meshConfig_defaultConfig_proxyMetadata_IstioMetaDNSCapture"></a> [istiod\_meshConfig\_defaultConfig\_proxyMetadata\_IstioMetaDNSCapture](#input\_istiod\_meshConfig\_defaultConfig\_proxyMetadata\_IstioMetaDNSCapture) | The mesh config default for ISTIO\_META\_DNS\_CAPTURE, enable or disable, default 'true' | `string` | `"true"` | no |
| <a name="input_istiod_meshConfig_enableAutoMtls"></a> [istiod\_meshConfig\_enableAutoMtls](#input\_istiod\_meshConfig\_enableAutoMtls) | The mesh config enable automtls, default 'true' | `string` | `"true"` | no |
| <a name="input_istiod_meshConfig_rootNamespace"></a> [istiod\_meshConfig\_rootNamespace](#input\_istiod\_meshConfig\_rootNamespace) | The mesh config root namespace | `string` | `"istio-system"` | no |
| <a name="input_istiod_pilot_env_PilotSkipValidateTrustDomain"></a> [istiod\_pilot\_env\_PilotSkipValidateTrustDomain](#input\_istiod\_pilot\_env\_PilotSkipValidateTrustDomain) | Pilot skip validate trust domain flag, default 'true' | `string` | `"true"` | no |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | The K8s namespace in which to install the Helm chart, default: 'istio-system' | `string` | `"istio-system"` | no |
| <a name="input_recreate_pods"></a> [recreate\_pods](#input\_recreate\_pods) | (Optional) Perform pods restart during upgrade/rollback. Defaults to false. | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->


## Contributing

### Updated Readme by [terraform-docs](https://terraform-docs.io/user-guide/how-to/)

```
terraform-docs markdown . --output-file README.md
```

### Automated testing on module

Testing is done via GHA workflow using K8s Kind. See `.tests/`
