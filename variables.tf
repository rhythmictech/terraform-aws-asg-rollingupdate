# =============================================
# Variables
# =============================================
variable "batch_max_size" {
  description = "Maximum batch size for ASG rolling updates"
  type        = string
  default     = 1
}

variable "health_check_type" {
  description = "Check instance health with EC2 or ELB checks"
  type        = string
  default     = "EC2"
}

variable "health_check_path" {
  description = "Path of HTTP Health Check"
  type        = string
  default     = "EC2"
}

variable "health_check_port" {
  description = "Path of HTTP Health Check"
  type        = number
  default     = 80
}

variable "image_id" {
  description = "AMI ID to use for this cluster"
  type        = string
}

variable "instance_type" {
  description = "Instance type to use in ASG"
  type        = string
  default     = "t3.micro"
}

variable "max_instances" {
  description = "Max instances in ASG"
  type        = string
  default     = 4
}

variable "min_instances" {
  description = "Min instances in ASG"
  type        = string
  default     = 2
}

variable "name" {
  description = "common name for resources in this module"
  type        = string
  default     = "ec2-spot-cluster"
}

variable "subnet_ids" {
  description = "Subnets ALB will listen on"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID to use for target group"
  type        = string
}

variable "lb_listener_port" {
  description = "Port on which LB will listen"
  type        = number
  default     = 80
}

variable "aws_lb_internal" {
  description = "The Load Balancer which fronts the ASG is internal"
  type        = bool
  default     = true
}

variable "instance_security_groups" {
  description = "Security groups to apply to instances in ASG"
  type        = list(string)
}

variable "lb_security_groups" {
  description = "Security groups to apply to Load Balancer"
  type        = list(string)
}

variable "tags" {}
