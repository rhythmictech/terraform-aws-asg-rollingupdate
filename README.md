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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.76.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [null_resource.tags_for_asg](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.tags_for_lt](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_lb_internal"></a> [aws\_lb\_internal](#input\_aws\_lb\_internal) | The Load Balancer which fronts the ASG is internal | `bool` | `true` | no |
| <a name="input_batch_max_size"></a> [batch\_max\_size](#input\_batch\_max\_size) | Maximum batch size for ASG rolling updates | `string` | `1` | no |
| <a name="input_elb_drop_invalid_headers"></a> [elb\_drop\_invalid\_headers](#input\_elb\_drop\_invalid\_headers) | Invalid headers being passed through to the target of the load balance may exploit vulnerabilities | `bool` | `true` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | Path of HTTP Health Check | `string` | `"EC2"` | no |
| <a name="input_health_check_port"></a> [health\_check\_port](#input\_health\_check\_port) | Path of HTTP Health Check | `number` | `80` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | Check instance health with EC2 or ELB checks | `string` | `"EC2"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | AMI ID to use for this cluster | `string` | `""` | no |
| <a name="input_instance_security_groups"></a> [instance\_security\_groups](#input\_instance\_security\_groups) | Security groups to apply to instances in ASG | `list(string)` | `[]` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use in ASG | `string` | `""` | no |
| <a name="input_keypair_name"></a> [keypair\_name](#input\_keypair\_name) | Name of an externally created keypair to attach to the automatically created instances. This only applies if launch\_template\_name is defined AND scaling\_object\_type is set to 'launchtemplate' | `string` | `""` | no |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | Name of externally created launch template to use with this module. If not defined and scaling\_object\_type is set to 'launchtemplate' (the default value), this will cause a launch template to be created in the cloudformation template | `string` | `""` | no |
| <a name="input_launch_template_overrides"></a> [launch\_template\_overrides](#input\_launch\_template\_overrides) | A list of maps defining any overrides to the Mixed Instance Policy Template. Required for Mixed Instance Policies. The map can contain the following values: instanceType (AWS Instance Type), launchTemplateSpecification (a separate launch template to use, object consisting of either launchTemplateId or launchTemplateName and optionally version), weightedCapacity (a weighted capacity entry for how frequently to use this override) | `list(map(string))` | `[]` | no |
| <a name="input_launch_template_version"></a> [launch\_template\_version](#input\_launch\_template\_version) | Version of externally created launch template to use with this module. If launch\_template\_name is defined this MUST be defined. | `string` | `""` | no |
| <a name="input_lb_access_logging_bucket"></a> [lb\_access\_logging\_bucket](#input\_lb\_access\_logging\_bucket) | Optional target for ALB access logging | `string` | `null` | no |
| <a name="input_lb_access_logging_prefix"></a> [lb\_access\_logging\_prefix](#input\_lb\_access\_logging\_prefix) | Optional target prefix for ALB access logging (only used if `lb_access_logging_bucket` is set) | `string` | `null` | no |
| <a name="input_lb_listener_certificate"></a> [lb\_listener\_certificate](#input\_lb\_listener\_certificate) | ARN of the certificate to attach to the LB. Only if lb\_listener\_protocol is HTTPS | `string` | `""` | no |
| <a name="input_lb_listener_port"></a> [lb\_listener\_port](#input\_lb\_listener\_port) | Port on which LB will listen | `number` | `80` | no |
| <a name="input_lb_listener_protocol"></a> [lb\_listener\_protocol](#input\_lb\_listener\_protocol) | Protcol on which LB will listen | `string` | `"HTTP"` | no |
| <a name="input_lb_listener_ssl_policy"></a> [lb\_listener\_ssl\_policy](#input\_lb\_listener\_ssl\_policy) | AWS SSL Security Policy to use with an HTTPS listener on the Load Balancer | `string` | `"ELBSecurityPolicy-TLS-1-2-Ext-2018-06"` | no |
| <a name="input_lb_security_groups"></a> [lb\_security\_groups](#input\_lb\_security\_groups) | Security groups to apply to Load Balancer | `list(string)` | n/a | yes |
| <a name="input_max_instance_lifetime"></a> [max\_instance\_lifetime](#input\_max\_instance\_lifetime) | Maximum lifetime of instances in ASG in seconds (values must be either equal to 0 or between 604800 and 31536000 seconds.) | `number` | `0` | no |
| <a name="input_max_instances"></a> [max\_instances](#input\_max\_instances) | Max instances in ASG | `string` | `4` | no |
| <a name="input_min_instances"></a> [min\_instances](#input\_min\_instances) | Min instances in ASG | `string` | `2` | no |
| <a name="input_min_instances_in_service"></a> [min\_instances\_in\_service](#input\_min\_instances\_in\_service) | Minimum number of instances that must remain in service when autoscaling group is updated | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | common name for resources in this module | `string` | `"ec2-spot-cluster"` | no |
| <a name="input_on_demand_allocation_strategy"></a> [on\_demand\_allocation\_strategy](#input\_on\_demand\_allocation\_strategy) | Strategy for allocation of instances to fulfill On-Demand capacity. Only valid value is currently 'prioritized'. | `string` | `"prioritized"` | no |
| <a name="input_on_demand_base_capacity"></a> [on\_demand\_base\_capacity](#input\_on\_demand\_base\_capacity) | Minimum amount of the ASG Capacity that should be filled with On Demand instances | `number` | `0` | no |
| <a name="input_on_demand_percent_above_base_capacity"></a> [on\_demand\_percent\_above\_base\_capacity](#input\_on\_demand\_percent\_above\_base\_capacity) | Percentage of the instances beyond the base capacity of the ASG that should be On Demand | `number` | `100` | no |
| <a name="input_pause_time"></a> [pause\_time](#input\_pause\_time) | Time to wait for a new instance to check-in before marking it as failed. Specify PauseTime in the ISO8601 duration format (in the format PT#H#M#S, where each # is the number of hours, minutes, and seconds, respectively). | `string` | `"PT5M"` | no |
| <a name="input_scaling_object_type"></a> [scaling\_object\_type](#input\_scaling\_object\_type) | The object type the autoscaling group should use as the basis for its instances. The default value is 'LaunchTemplate'. MixedInstancesPolicy is also supported, and future values may include 'LaunchConfigurationName', and 'InstanceId' | `string` | `"launchtemplate"` | no |
| <a name="input_spot_allocation_strategy"></a> [spot\_allocation\_strategy](#input\_spot\_allocation\_strategy) | Method by which to allocate spot instances for a MixedInstancesPolicy deployment. Valid values are lowest-price, capacity-optimized, and capacity-optimized-prioritized. | `string` | `"lowest-price"` | no |
| <a name="input_spot_instance_pools"></a> [spot\_instance\_pools](#input\_spot\_instance\_pools) | Number of Spot Instance pools to allocate your spot capacity for a MixedInstancesPolicy deployment. Applies only when lowest-price allocation strategy is in effect. | `number` | `2` | no |
| <a name="input_spot_max_price"></a> [spot\_max\_price](#input\_spot\_max\_price) | Maximum price to pay for Spot Instances in a MixedInstancesPolicy deployment. Default is blank, which equates to the price of on-demand instances. | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnets ALB will listen on | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags definition to apply to resources | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to use for target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_cloudformation_stack"></a> [aws\_cloudformation\_stack](#output\_aws\_cloudformation\_stack) | AWS ASG CFN Stack resource |
| <a name="output_aws_lb"></a> [aws\_lb](#output\_aws\_lb) | AWS LB resource |
| <a name="output_aws_lb_listener"></a> [aws\_lb\_listener](#output\_aws\_lb\_listener) | AWS LB listener resource |
| <a name="output_aws_lb_target_group"></a> [aws\_lb\_target\_group](#output\_aws\_lb\_target\_group) | AWS LB Target Group resource |
| <a name="output_rendered"></a> [rendered](#output\_rendered) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## The Giants underneath this module
- pre-commit.com/
- terraform.io/
- github.com/tfutils/tfenv
- github.com/segmentio/terraform-docs
