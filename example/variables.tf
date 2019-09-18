variable "alb_subnet_ids" {
  description = "Subnets ALB will listen on"
  type        = list(string)
}

variable "asg_health_check_path" {
  description = "Path of HTTP Health Check"
  type        = string
}

variable "vpc_id" {
  description = "ID of VPC in which to instanciate resources"
  type        = string
}

variable "instance_security_groups" {
  description = "Security groups to apply to instances in ASG"
  type        = list(string)
}

variable "lb_security_groups" {
  description = "Security groups to apply to Load Balancer"
  type        = list(string)
}
