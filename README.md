# terraform-aws-asg-rollingupdate
[![tflint](https://github.com/rhythmictech/terraform-anycloud-template/workflows/tflint/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-anycloud-template/actions?query=workflow%3Atflint+event%3Apush+branch%3Amain)
[![tfsec](https://github.com/rhythmictech/terraform-anycloud-template/workflows/tfsec/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-anycloud-template/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amain)
[![yamllint](https://github.com/rhythmictech/terraform-anycloud-template/workflows/yamllint/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-anycloud-template/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amain)
[![misspell](https://github.com/rhythmictech/terraform-anycloud-template/workflows/misspell/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-anycloud-template/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amain)
[![pre-commit-check](https://github.com/rhythmictech/terraform-anycloud-template/workflows/pre-commit-check/badge.svg?branch=main&event=push)](https://github.com/rhythmictech/terraform-anycloud-template/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amain)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

Terraform module to create Autoscaling Group in AWS with AutoScalingRollingUpdates

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| lb\_security\_groups | Security groups to apply to Load Balancer | `list(string)` | n/a | yes |
| min\_instances\_in\_service | Minimum number of instances that must remain in service when autoscaling group is updated | `string` | n/a | yes |
| subnet\_ids | Subnets ALB will listen on | `list(string)` | n/a | yes |
| tags | Tags definition to apply to resources | `map(string)` | n/a | yes |
| vpc\_id | VPC ID to use for target group | `string` | n/a | yes |
| aws\_lb\_internal | The Load Balancer which fronts the ASG is internal | `bool` | `true` | no |
| batch\_max\_size | Maximum batch size for ASG rolling updates | `string` | `1` | no |
| health\_check\_path | Path of HTTP Health Check | `string` | `"EC2"` | no |
| health\_check\_port | Path of HTTP Health Check | `number` | `80` | no |
| health\_check\_type | Check instance health with EC2 or ELB checks | `string` | `"EC2"` | no |
| image\_id | AMI ID to use for this cluster | `string` | `""` | no |
| instance\_security\_groups | Security groups to apply to instances in ASG | `list(string)` | `[]` | no |
| instance\_type | Instance type to use in ASG | `string` | `""` | no |
| keypair\_name | Name of an externally created keypair to attach to the automatically created instances. This only applies if launch\_template\_name is defined AND scaling\_object\_type is set to 'launchtemplate' | `string` | `""` | no |
| launch\_template\_name | Name of externally created launch template to use with this module. If not defined and scaling\_object\_type is set to 'launchtemplate' (the default value), this will cause a launch template to be created in the cloudformation template | `string` | `""` | no |
| launch\_template\_version | Version of externally created launch template to use with this module. If launch\_template\_name is defined this MUST be defined. | `string` | `""` | no |
| lb\_listener\_certificate | ARN of the certificate to attach to the LB. Only if lb\_listener\_protocol is HTTPS | `string` | `""` | no |
| lb\_listener\_port | Port on which LB will listen | `number` | `80` | no |
| lb\_listener\_protocol | Protcol on which LB will listen | `string` | `"HTTP"` | no |
| lb\_listener\_ssl\_policy | AWS SSL Security Policy to use with an HTTPS listener on the Load Balancer | `string` | `"ELBSecurityPolicy-TLS-1-2-Ext-2018-06"` | no |
| max\_instance\_lifetime | Maximum lifetime of instances in ASG in seconds (values must be either equal to 0 or between 604800 and 31536000 seconds.) | `number` | `0` | no |
| max\_instances | Max instances in ASG | `string` | `4` | no |
| min\_instances | Min instances in ASG | `string` | `2` | no |
| name | common name for resources in this module | `string` | `"ec2-spot-cluster"` | no |
| scaling\_object\_type | The object type the autoscaling group should use as the basis for its instances. The default (and currently the only supported) value is 'LaunchTemplate'. Future values may include 'MixedInstancesPolicy', 'LaunchConfigurationName', and 'InstanceId' | `string` | `"launchtemplate"` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_cloudformation\_stack | AWS ASG CFN Stack resource |
| aws\_lb | AWS LB resource |
| aws\_lb\_listener | AWS LB listener resource |
| aws\_lb\_target\_group | AWS LB Target Group resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants underneath this module
- pre-commit.com/
- terraform.io/
- github.com/tfutils/tfenv
- github.com/segmentio/terraform-docs
