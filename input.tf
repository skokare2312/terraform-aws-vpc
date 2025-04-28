variable "vpc" {
  description = "VPC configuration"
  type = object({
    Name                    = string
    Environment             = string
    Project                 = string
    Owner                   = string
    cidr_block              = string
    instance_tenancy        = optional(string, "default")
    enable_dns_support      = optional(bool, true)
    enable_dns_hostnames    = optional(bool, true)
    public_subnet_required  = optional(bool, true)
    private_subnet_required = optional(bool, false)
  })
  default = {
    Name                    = "kulbhushanmayer"
    Environment             = "Learning"
    Project                 = "Thinknyx"
    Owner                   = "Kulbhushan"
    cidr_block              = "10.10.0.0/16"
    private_subnet_required = true
    public_subnet_required  = true
  }
}