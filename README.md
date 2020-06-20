# terraform-aws-asg-rollingupdate
[![](https://github.com/rhythmictech/terraform-aws-asg-rollingupdate/workflows/pre-commit-check/badge.svg)](https://github.com/rhythmictech/terraform-aws-asg-rollingupdate/actions) <a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=RhythmicTech" alt="follow on Twitter"></a>

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
| aws\_cloudformation\_stack | n/a |
| aws\_lb | n/a |
| aws\_lb\_listener | n/a |
| aws\_lb\_target\_group | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants underneath this module
- pre-commit.com/
- terraform.io/
- github.com/tfutils/tfenv
- github.com/segmentio/terraform-docs
