## Module Name: terraform-helm-istio
#### Description: Install and setup Istio via Helm

### Updated Readme by [terraform-docs](https://terraform-docs.io/user-guide/how-to/)

```
terraform-docs markdown . --output-file README.md
```
### Automated testing on module

testing performed via pipeline on each Pull Request. It will turn up tests EKS and tear it down.
See `./tests` folder for more details

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
| [helm_release.istio-gateway](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.istio-gateway-elb](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
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
| <a name="input_elb_load_balancer"></a> [elb\_load\_balancer](#input\_elb\_load\_balancer) | n/a | `map` | <pre>{<br>  "service": {<br>    "annotations": {<br>      "service.beta.kubernetes.io/aws-load-balancer-internal": "true"<br>    },<br>    "ports": [<br>      {<br>        "name": "https",<br>        "port": 443,<br>        "protocol": "TCP",<br>        "targetPort": 443<br>      },<br>      {<br>        "name": "http2",<br>        "port": 80,<br>        "protocol": "TCP",<br>        "targetPort": 80<br>      },<br>      {<br>        "name": "status-port",<br>        "port": 15021,<br>        "protocol": "TCP",<br>        "targetPort": 15021<br>      },<br>      {<br>        "name": "grpc",<br>        "port": 50051,<br>        "protocol": "TCP",<br>        "targetPort": 50051<br>      },<br>      {<br>        "name": "tls",<br>        "port": 15443,<br>        "protocol": "TCP",<br>        "targetPort": 15443<br>      }<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_force_update"></a> [force\_update](#input\_force\_update) | (Optional) Force resource update through delete/recreate if needed. Defaults to false | `bool` | `false` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Version of the Helm chart | `string` | `"1.12.6"` | no |
| <a name="input_helm_repo_url"></a> [helm\_repo\_url](#input\_helm\_repo\_url) | Helm repository | `string` | `"https://istio-release.storage.googleapis.com/charts"` | no |
| <a name="input_istio_base_settings"></a> [istio\_base\_settings](#input\_istio\_base\_settings) | Additional settings which will be passed to the Helm chart values, yamldecode will be performed on the HCL | `map(any)` | `{}` | no |
| <a name="input_istio_elb_gw_enabled"></a> [istio\_elb\_gw\_enabled](#input\_istio\_elb\_gw\_enabled) | enable or disable the istio gw install that has an ELB for load balancer, default true | `bool` | `false` | no |
| <a name="input_istio_gw_enabled"></a> [istio\_gw\_enabled](#input\_istio\_gw\_enabled) | enable or disable the istio gw install that has an ELB for load balancer, default true | `bool` | `false` | no |
| <a name="input_istio_meshconfig_mesh_name"></a> [istio\_meshconfig\_mesh\_name](#input\_istio\_meshconfig\_mesh\_name) | Istio telementry mesh name, default mesh1 | `string` | `"mesh1"` | no |
| <a name="input_istio_meshconfig_network"></a> [istio\_meshconfig\_network](#input\_istio\_meshconfig\_network) | Istio telementry network name, default network1 | `string` | `"network1"` | no |
| <a name="input_istio_private_gateway_settings"></a> [istio\_private\_gateway\_settings](#input\_istio\_private\_gateway\_settings) | Additional settings which will be passed to the Helm chart values, yamldecode will be performed on the HCL | `map(any)` | `{}` | no |
| <a name="input_istiod_settings"></a> [istiod\_settings](#input\_istiod\_settings) | Additional settings which will be passed to the Helm chart values, yamldecode will be performed on the HCL | `map(any)` | `{}` | no |
| <a name="input_k8s_namespace"></a> [k8s\_namespace](#input\_k8s\_namespace) | The K8s namespace in which to install the Helm chart, default: 'istio-system' | `string` | `"istio-system"` | no |
| <a name="input_nlb_load_balancer"></a> [nlb\_load\_balancer](#input\_nlb\_load\_balancer) | n/a | `map` | <pre>{<br>  "service": {<br>    "annotations": {<br>      "service.beta.kubernetes.io/aws-load-balancer-internal": "true",<br>      "service.beta.kubernetes.io/aws-load-balancer-type": "nlb"<br>    },<br>    "ports": [<br>      {<br>        "name": "https",<br>        "port": 443,<br>        "protocol": "TCP",<br>        "targetPort": 443<br>      },<br>      {<br>        "name": "http2",<br>        "port": 80,<br>        "protocol": "TCP",<br>        "targetPort": 80<br>      },<br>      {<br>        "name": "status-port",<br>        "port": 15021,<br>        "protocol": "TCP",<br>        "targetPort": 15021<br>      },<br>      {<br>        "name": "grpc",<br>        "port": 50051,<br>        "protocol": "TCP",<br>        "targetPort": 50051<br>      },<br>      {<br>        "name": "tls",<br>        "port": 15443,<br>        "protocol": "TCP",<br>        "targetPort": 15443<br>      }<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_recreate_pods"></a> [recreate\_pods](#input\_recreate\_pods) | (Optional) Perform pods restart during upgrade/rollback. Defaults to false. | `bool` | `false` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | provide the subnets used by load balancer for istio gateway | `list` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
