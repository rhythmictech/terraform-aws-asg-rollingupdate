
# =============================================
# Variables
# =============================================

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  common_tags = {
    Name                = "My ASG"
    terraform_managed   = true
    terraform_workspace = terraform.workspace
  }
}

# =============================================
# Infrastructure
# =============================================

data "aws_ami" "this" {
  most_recent = true
  owners      = ["self"]
  name_regex  = "my-jetty-ami"
}

module "this" {
  source                   = "../"
  subnet_ids               = var.alb_subnet_ids
  health_check_path        = var.asg_health_check_path
  image_id                 = data.aws_ami.this.id
  vpc_id                   = var.vpc_id
  instance_security_groups = var.instance_security_groups
  lb_security_groups       = var.lb_security_groups
  tags                     = local.common_tags
}
