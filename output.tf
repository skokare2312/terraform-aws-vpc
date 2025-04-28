output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.aws_vpc.id
}
output "subnet_count" {
  description = "The number of subnets created"
  value       = local.az_count
}
output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [
    for id in module.create_public_subnets: id.subnet_id
  ]
}
output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.create_private_subnets.*.subnet_id 
}
output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_vpc.aws_vpc.default_security_group_id
}