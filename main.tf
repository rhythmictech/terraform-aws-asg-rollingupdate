# resources to reformat tags
# transform from map to json for CloudFormation template
resource "null_resource" "tags_for_asg" {
  count = length(keys(var.tags))

  triggers = {
    "Key"               = keys(var.tags)[count.index]
    "Value"             = values(var.tags)[count.index]
    "PropagateAtLaunch" = true
  }
}

resource "null_resource" "tags_for_lt" {
  count = length(keys(var.tags))

  triggers = {
    "Key"   = keys(var.tags)[count.index]
    "Value" = values(var.tags)[count.index]
  }
}

locals {
  tags_asg_format = jsonencode(null_resource.tags_for_asg.*.triggers)
  tags_lt_format  = jsonencode(null_resource.tags_for_lt.*.triggers)
}

# =============================================
# Main
# =============================================

resource "aws_lb_target_group" "this" {
  name_prefix = substr("${var.name}-tg", 0, 6)
  port        = var.health_check_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  slow_start  = 60

  health_check {
    protocol          = "HTTP"
    path              = var.health_check_path
    healthy_threshold = "2"
  }

  tags = var.tags
}

resource "aws_lb" "this" {
  name               = "${var.name}-alb"
  internal           = var.aws_lb_internal
  load_balancer_type = "application"
  security_groups    = var.lb_security_groups
  subnets            = var.subnet_ids

  tags = var.tags
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name_prefix = var.name
  public_key      = tls_private_key.this.public_key_openssh
}

module "asg_instance_key" {
  source = "github.com/rhythmictech/terraform-aws-secretsmanager-secret?ref=v0.0.3"

  name        = "${var.name}-key"
  description = "Instance key for asg ${var.name}"
  value       = tls_private_key.this.private_key_pem
  tags        = var.tags
}

data "template_file" "this" {
  template = file("${path.module}/auto-scaling-group.yml")

  vars = {
    launch_template_name     = var.name
    image_id                 = var.image_id
    instance_type            = var.instance_type
    instance_security_groups = join("\", \"", var.instance_security_groups)
    key_name                 = aws_key_pair.this.key_name
    tags                     = local.tags_lt_format

    description  = "Autoscaling group for EC2 cluster"
    subnets      = join("\",\"", var.subnet_ids)
    minSize      = var.min_instances
    maxSize      = var.max_instances
    healthCheck  = var.health_check_type
    maxBatch     = var.batch_max_size
    minInService = var.max_instances / 2
    name         = var.name
    targetGroups = aws_lb_target_group.this.id
    asg_tags     = local.tags_asg_format
  }
}

resource "aws_cloudformation_stack" "this" {
  name          = "${var.name}-asg-stack"
  template_body = data.template_file.this.rendered

  tags = var.tags
}
