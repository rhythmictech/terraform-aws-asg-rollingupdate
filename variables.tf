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
  description = "AMI ID to use for this cluster"
  type        = string
}

variable "instance_type" {
  default     = "t3.micro"
  description = "Instance type to use in ASG"
  type        = string
}

variable "instance_security_groups" {
  description = "Security groups to apply to instances in ASG"
  type        = list(string)
}

variable "lb_listener_port" {
  default     = 80
  description = "Port on which LB will listen"
  type        = number
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

variable "min_instances" {
  default     = 2
  description = "Min instances in ASG"
  type        = string
}

variable "name" {
  default     = "ec2-spot-cluster"
  description = "common name for resources in this module"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets ALB will listen on"
  type        = list(string)
}

variable "tags" {
  description = "Tags definition to apply to resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC ID to use for target group"
  type        = string
}
