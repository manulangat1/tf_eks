provider "aws" {
  region = "us-east-2"

}
variable "cidr_block" {
  type = string


}
variable "private_subnet_cidr_blocks" {
  #   type = string

}

variable "public_subnet_cidr_blocks" {
  #   type = string

}
data "aws_availability_zones" "azs" {

}

output "azs-dat" {
  value = data.aws_availability_zones.azs.names

}

module "vpc" {


  # source = ""
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  # the 14 required  variables for the vpc
  name = "my-vpc"
  cidr = var.cidr_block


  #best practise is to create one private and public subnets in each az's 
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks
  #set dynamically based on the regions 
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/my-app-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-app-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                   = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-app-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"          = 1
  }

  # output "private_subnets" {
  #   value = var.private_subnet_cidr_blocks
  # }
}
