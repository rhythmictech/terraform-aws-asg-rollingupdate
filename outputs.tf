# =============================================
# outputs
# =============================================

output "aws_lb_target_group" {
  value = aws_lb_target_group.this
}

output "aws_lb" {
  value = aws_lb.this
}

output "aws_lb_listener" {
  value = aws_lb_listener.this
}

output "aws_cloudformation_stack" {
  value = aws_cloudformation_stack.this
}
