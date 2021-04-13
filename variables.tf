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

variable "launch_template_name" {
  default     = ""
  description = "Name of externally created launch template to use with this module. If not defined and scaling_object_type is set to 'launchtemplate' (the default value), this will cause a launch template to be created in the cloudformation template"
  type        = string
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
  description = "The object type the autoscaling group should use as the basis for its instances. The default (and currently the only supported) value is 'LaunchTemplate'. Future values may include 'MixedInstancesPolicy', 'LaunchConfigurationName', and 'InstanceId'"
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
