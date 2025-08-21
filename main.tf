resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { Name = "tf-vpc" }
}

data "aws_availability_zones" "this" {
  state = "available"
}

locals {
  chosen_azs  = length(var.azs) > 0 ? var.azs : slice(data.aws_availability_zones.this.names, 0, 3)
  public_map  = { for i, az in local.chosen_azs : i => { az = az, cidr = var.public_subnet_cidrs[i] } }
  private_map = { for i, az in local.chosen_azs : i => { az = az, cidr = var.private_subnet_cidrs[i] } }
}

resource "aws_subnet" "public" {
  for_each                = local.public_map
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true
  tags                    = { Name = "tf-public-${each.key}" }
}

resource "aws_subnet" "private" {
  for_each          = local.private_map
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags              = { Name = "tf-private-${each.key}" }
}