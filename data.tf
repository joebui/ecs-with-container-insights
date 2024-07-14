data "aws_ami" "optimized_ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-ecs-hvm-2023.*"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

data "aws_security_group" "default" {
  name = var.security_group_name
}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
