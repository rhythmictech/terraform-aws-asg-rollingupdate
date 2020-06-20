########################################

# Outputs
########################################


output "alb_dns_name" {
  value = module.this.aws_lb.dns_name
}

output "asg_test_page" {
  value = "${module.this.aws_lb.dns_name}${var.asg_health_check_path}"
}
