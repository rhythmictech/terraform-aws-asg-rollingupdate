########################################
# Variables
########################################

variable "aws_lb_internal" {
  default     = true
  description = "The Load Balancer which fronts the ASG is internal"
  type        = bool
}

variable "batch_max_size" {
  default     = 1
  description = "Maximum batch size for ASG rolling updates"
  type        = string
}

variable "elb_drop_invalid_headers" {
  default     = true
  description = "Invalid headers being passed through to the target of the load balance may exploit vulnerabilities"
  type        = bool
}

variable "health_check_path" {
  default     = "EC2"
  description = "Path of HTTP Health Check"
  type        = string
}

variable "health_check_port" {
  default     = 80
  description = "Path of HTTP Health Check"
  type        = number
}

variable "health_check_type" {
  default     = "EC2"
  description = "Check instance health with EC2 or ELB checks"
  type        = string
}

variable "image_id" {
  default     = ""
  description = "AMI ID to use for this cluster"
  type        = string
}

variable "instance_type" {
  default     = ""
  description = "Instance type to use in ASG"
  type        = string
}

variable "instance_security_groups" {
  default     = []
  description = "Security groups to apply to instances in ASG"
  type        = list(string)
}

variable "keypair_name" {
  default     = ""
  description = "Name of an externally created keypair to attach to the automatically created instances. This only applies if launch_template_name is defined AND scaling_object_type is set to 'launchtemplate'"
  type        = string
}

variable "on_demand_allocation_strategy" {
  default     = "prioritized"
  description = "Strategy for allocation of instances to fulfill On-Demand capacity. Only valid value is currently 'prioritized'."
  type        = string
}

variable "on_demand_base_capacity" {
  default     = 0
  description = "Minimum amount of the ASG Capacity that should be filled with On Demand instances"
  type        = number
}

variable "on_demand_percent_above_base_capacity" {
  default     = 100
  description = "Percentage of the instances beyond the base capacity of the ASG that should be On Demand"
  type        = number
}

variable "launch_template_name" {
  default     = ""
  description = "Name of externally created launch template to use with this module. If not defined and scaling_object_type is set to 'launchtemplate' (the default value), this will cause a launch template to be created in the cloudformation template"
  type        = string
}

variable "launch_template_overrides" {
  default     = []
  description = "A list of maps defining any overrides to the Mixed Instance Policy Template. Required for Mixed Instance Policies. The map can contain the following values: instanceType (AWS Instance Type), launchTemplateSpecification (a separate launch template to use, object consisting of either launchTemplateId or launchTemplateName and optionally version), weightedCapacity (a weighted capacity entry for how frequently to use this override)"
  type        = list(map(string))
}

variable "launch_template_version" {
  default     = ""
  description = "Version of externally created launch template to use with this module. If launch_template_name is defined this MUST be defined."
  type        = string
}

variable "lb_access_logging_bucket" {
  default     = null
  description = "Optional target for ALB access logging"
  type        = string
}

variable "lb_access_logging_prefix" {
  default     = null
  description = "Optional target prefix for ALB access logging (only used if `lb_access_logging_bucket` is set)"
  type        = string
}

variable "lb_listener_certificate" {
  default     = ""
  description = "ARN of the certificate to attach to the LB. Only if lb_listener_protocol is HTTPS"
  type        = string
}

variable "lb_listener_port" {
  default     = 80
  description = "Port on which LB will listen"
  type        = number
}

variable "lb_listener_protocol" {
  default     = "HTTP"
  description = "Protcol on which LB will listen"
  type        = string
}

variable "lb_listener_ssl_policy" {
  default     = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  description = "AWS SSL Security Policy to use with an HTTPS listener on the Load Balancer"
  type        = string
}

variable "lb_security_groups" {
  description = "Security groups to apply to Load Balancer"
  type        = list(string)
}

variable "max_instances" {
  default     = 4
  description = "Max instances in ASG"
  type        = string
}

variable "max_instance_lifetime" {
  default     = 0
  description = "Maximum lifetime of instances in ASG in seconds (values must be either equal to 0 or between 604800 and 31536000 seconds.)"
  type        = number
}

variable "min_instances" {
  default     = 2
  description = "Min instances in ASG"
  type        = string
}

variable "min_instances_in_service" {
  description = "Minimum number of instances that must remain in service when autoscaling group is updated"
  type        = string
}

variable "name" {
  default     = "ec2-spot-cluster"
  description = "common name for resources in this module"
  type        = string
}

variable "pause_time" {
  default     = "PT5M"
  description = "Time to wait for a new instance to check-in before marking it as failed. Specify PauseTime in the ISO8601 duration format (in the format PT#H#M#S, where each # is the number of hours, minutes, and seconds, respectively). "
  type        = string
}

variable "subnet_ids" {
  description = "Subnets ALB will listen on"
  type        = list(string)
}

variable "scaling_object_type" {
  default     = "launchtemplate"
  description = "The object type the autoscaling group should use as the basis for its instances. The default value is 'LaunchTemplate'. MixedInstancesPolicy is also supported, and future values may include 'LaunchConfigurationName', and 'InstanceId'"
  type        = string
}

variable "spot_allocation_strategy" {
  default     = "lowest-price"
  description = "Method by which to allocate spot instances for a MixedInstancesPolicy deployment. Valid values are lowest-price, capacity-optimized, and capacity-optimized-prioritized."
  type        = string
}

variable "spot_instance_pools" {
  default     = 2
  description = "Number of Spot Instance pools to allocate your spot capacity for a MixedInstancesPolicy deployment. Applies only when lowest-price allocation strategy is in effect."
  type        = number
}

variable "spot_max_price" {
  default     = ""
  description = "Maximum price to pay for Spot Instances in a MixedInstancesPolicy deployment. Default is blank, which equates to the price of on-demand instances."
  type        = string
}

variable "tags" {
  description = "Tags definition to apply to resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC ID to use for target group"
  type        = string
}
