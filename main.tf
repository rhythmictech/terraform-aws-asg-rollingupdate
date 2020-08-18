########################################
# Tagging
# resources to reformat tags
# transform from map to json for CloudFormation template
########################################

locals {
  tags_asg_format = jsonencode(null_resource.tags_for_asg.*.triggers)
  tags_lt_format  = jsonencode(null_resource.tags_for_lt.*.triggers)
  create_lt       = var.launch_template_name == "" && lower(var.scaling_object_type) == "launchtemplate"
}

resource "null_resource" "tags_for_asg" {
  count = length(keys(var.tags))

  triggers = {
    "Key"               = keys(var.tags)[count.index]
    "PropagateAtLaunch" = true
    "Value"             = values(var.tags)[count.index]
  }
}

resource "null_resource" "tags_for_lt" {
  count = length(keys(var.tags))

  triggers = {
    "Key"   = keys(var.tags)[count.index]
    "Value" = values(var.tags)[count.index]
  }
}

########################################
# LB
########################################

data "template_file" "this" {
  template = file("${path.module}/auto-scaling-group.yml.tpl")

  vars = {
    name                     = var.name
    asg_tags                 = local.tags_asg_format
    createLt                 = local.create_lt
    description              = "Autoscaling group for EC2 cluster"
    healthCheck              = var.health_check_type
    image_id                 = var.image_id
    instance_security_groups = join("\", \"", var.instance_security_groups)
    instance_type            = var.instance_type
    key_name                 = var.keypair_name
    launchTemplateName       = var.launch_template_name
    launchTemplateVersion    = var.launch_template_version
    maxBatch                 = var.batch_max_size
    maxLifetime              = var.max_instance_lifetime
    maxSize                  = var.max_instances
    minInService             = var.min_instances_in_service
    minSize                  = var.min_instances
    scalingObject            = var.scaling_object_type
    tags                     = local.tags_lt_format
    targetGroups             = aws_lb_target_group.this.id
    subnets                  = join("\",\"", var.subnet_ids)
  }
}

resource "aws_cloudformation_stack" "this" {
  name          = "${var.name}-asg-stack"
  tags          = var.tags
  template_body = data.template_file.this.rendered
}

resource "aws_lb" "this" {
  name               = "${var.name}-alb"
  internal           = var.aws_lb_internal
  load_balancer_type = "application"
  security_groups    = var.lb_security_groups
  subnets            = var.subnet_ids
  tags               = var.tags
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol #tfsec:ignore:AWS004

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_certificate" "this" {
  count = (var.lb_listener_certificate != "" && var.lb_listener_protocol == "HTTPS") ? 1 : 0

  listener_arn    = aws_lb_listener.this.arn
  certificate_arn = var.lb_listener_certificate
}

resource "aws_lb_target_group" "this" {
  name_prefix = substr("${var.name}-tg", 0, 6)
  port        = var.health_check_port
  protocol    = "HTTP"
  slow_start  = 60
  tags        = var.tags
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold = "2"
    path              = var.health_check_path
    protocol          = "HTTP" #tfsec:ignore:AWS004, TODO: make var
  }
}
