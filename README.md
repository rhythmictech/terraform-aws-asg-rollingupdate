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
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| image\_id | AMI ID to use for this cluster | `string` | n/a | yes |
| instance\_security\_groups | Security groups to apply to instances in ASG | `list(string)` | n/a | yes |
| lb\_security\_groups | Security groups to apply to Load Balancer | `list(string)` | n/a | yes |
| subnet\_ids | Subnets ALB will listen on | `list(string)` | n/a | yes |
| tags | Tags definition to apply to resources | `map(string)` | n/a | yes |
| vpc\_id | VPC ID to use for target group | `string` | n/a | yes |
| aws\_lb\_internal | The Load Balancer which fronts the ASG is internal | `bool` | `true` | no |
| batch\_max\_size | Maximum batch size for ASG rolling updates | `string` | `1` | no |
| health\_check\_path | Path of HTTP Health Check | `string` | `"EC2"` | no |
| health\_check\_port | Path of HTTP Health Check | `number` | `80` | no |
| health\_check\_type | Check instance health with EC2 or ELB checks | `string` | `"EC2"` | no |
| instance\_type | Instance type to use in ASG | `string` | `"t3.micro"` | no |
| lb\_listener\_port | Port on which LB will listen | `number` | `80` | no |
| max\_instances | Max instances in ASG | `string` | `4` | no |
| min\_instances | Min instances in ASG | `string` | `2` | no |
| name | common name for resources in this module | `string` | `"ec2-spot-cluster"` | no |

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
