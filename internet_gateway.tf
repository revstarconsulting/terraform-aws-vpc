resource "aws_internet_gateway" "this" {
  count = var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.igw_tags,
    local.common_tags
  )
}

# Egress Only Internet Gateway for IPv6 associated with Private Subnets

resource "aws_egress_only_internet_gateway" "this" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.igw_tags,
    local.common_tags
  )
}