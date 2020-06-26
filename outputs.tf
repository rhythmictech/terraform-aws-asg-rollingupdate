########################################
# outputs
########################################

output "aws_cloudformation_stack" {
  description = "AWS ASG CFN Stack resource"
  value       = aws_cloudformation_stack.this
}

output "aws_lb" {
  description = "AWS LB resource"
  value       = aws_lb.this
}

output "aws_lb_listener" {
  description = "AWS LB listener resource"
  value       = aws_lb_listener.this
}

output "aws_lb_target_group" {
  description = "AWS LB Target Group resource"
  value       = aws_lb_target_group.this
}
