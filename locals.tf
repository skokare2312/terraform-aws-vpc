locals {
  tags = {
    Name        = var.vpc.Name
    Environment = var.vpc.Environment
    Project     = var.vpc.Project
    Owner       = var.vpc.Owner
  }
  az_count = length(data.aws_availability_zones.available.names)
}