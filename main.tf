locals {
  public_count              = "${var.enabled == "true" && var.type == "public" ? length(var.availability_zones) : 0}"
  public_nat_gateways_count = "${var.enabled == "true" && var.type == "public" ? length(var.availability_zones) : 0}"
}

resource "aws_subnet" "public" {
  count             = "${local.public_count}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${cidrsubnet(var.cidr_block, ceil(log(var.max_subnets, 2)), count.index)}"

  tags = {
    Name         = "${var.Name}"
    Environment  = "${var.Environment}"
    CreatedBy    = "${var.CreatedBy}"
    Organization = "${var.Organization}"
  }
}

resource "aws_network_acl" "public" {
  count      = "${var.enabled == "true" && var.type == "public" && signum(length(var.public_network_acl_id)) == 0 ? 1 : 0}"
  vpc_id     = "${var.vpc_id}"
  subnet_ids = ["${aws_subnet.public.*.id}"]
  egress     = "${var.public_network_acl_egress}"
  ingress    = "${var.public_network_acl_ingress}"

  tags = {
    Name         = "${var.Name}"
    Environment  = "${var.Environment}"
    CreatedBy    = "${var.CreatedBy}"
    Organization = "${var.Organization}"
  }

  depends_on = ["aws_subnet.public"]
}

resource "aws_route_table" "public" {
  count  = "${local.public_count}"
  vpc_id = "${var.vpc_id}"

  tags = {
    Name         = "${var.Name}"
    Environment  = "${var.Environment}"
    CreatedBy    = "${var.CreatedBy}"
    Organization = "${var.Organization}"
  }
}

resource "aws_route" "public" {
  count                  = "${local.public_count}"
  route_table_id         = "${element(aws_route_table.public.*.id, count.index)}"
  gateway_id             = "${var.igw_id}"
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = ["aws_route_table.public"]
}

resource "aws_route_table_association" "public" {
  count          = "${local.public_count}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
  depends_on     = ["aws_subnet.public", "aws_route_table.public"]
}
