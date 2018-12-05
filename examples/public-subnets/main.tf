locals {
  public_cidr_block = "${cidrsubnet(var.cidr_block, 1, 0)}"
}

module "public_subnets" {
  source              = "../../"
  organization        = "Namespace"
  environment         = "Stage"
  name                = "Name"
  availability_zones  = ["eu-wast-1a", "eu-wast-1b", "eu-wast-1c"]
  vpc_id              = "${var.vpc_id}"
  cidr_block          = "${local.public_cidr_block}"
  type                = "public"
  igw_id              = "${var.igw_id}"
  nat_gateway_enabled = "false"
}
