data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.vpc.cidr_block
  enable_dns_support   = var.vpc.enable_dns_support
  enable_dns_hostnames = var.vpc.enable_dns_hostnames
  instance_tenancy     = var.vpc.instance_tenancy
  tags                 = local.tags
}

resource "aws_ec2_tag" "tag_default_vpc_resources" {
  for_each = {
    default_security_group_id = aws_vpc.aws_vpc.default_security_group_id,
    default_network_acl_id    = aws_vpc.aws_vpc.default_network_acl_id,
    default_route_table_id    = aws_vpc.aws_vpc.default_route_table_id
  }
  resource_id = each.value
  key         = "Name"
  value       = var.vpc.Name
}

module "create_public_subnets" {
  count                     = var.vpc.public_subnet_required == false ? 0 : 1 # if public_subnet_required is false, skip the module creation
  source                    = "kmayer10/create-subnet/aws"                       # location to get the module definition, remote or local, current is REMOTE
  version                   = "1.0.0"
  subnet_count              = local.az_count
  vpc_id                    = aws_vpc.aws_vpc.id
  tags                      = local.tags
  type                      = "public"
  internet_gateway_required = true
}

module "create_private_subnets" {
  count                = var.vpc.private_subnet_required == false ? 0 : 1 # if private_subnet_required is false, skip the module creation
  source               = "kmayer10/create-subnet/aws"                       # location to get the module definition, remote or local, current is REMOTE
  version              = "1.0.0"
  subnet_count         = local.az_count
  vpc_id               = aws_vpc.aws_vpc.id
  tags                 = local.tags
  subnet_series        = 10
  nat_gateway_required = true
  nat_subnet_id        = module.create_public_subnets[0].subnet_id
}
