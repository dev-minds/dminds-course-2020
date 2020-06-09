data "aws_ami" "mgmnt_ami_choice" {
  most_recent = true
  owners      = ["self"]
  name_regex  = "^LiveManagementNodeAmi.*"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Server Definition
provider "aws" {
  profile = var.profile_name
  region  = var.aws_region
  version = "~> 2.7"
}

terraform {
  required_version = ">= 0.12.24"

  backend "s3" {
    bucket  = "vpc-states"
    key     = "live_mgmnt_state/managementenv.tfstate"
    region  = "eu-west-1"
    encrypt = "true"
  }
}

data "terraform_remote_state" "dm_vpc_state_ds" {
  backend = "s3"

  config = {
    bucket = "vpc-states"
    key    = "centralevpc/management-env.tfstate"
    region = "${var.aws_region}"
  }
}

resource "aws_instance" "dm_bastion_inst_res" {
  ami                    = data.aws_ami.mgmnt_ami_choice.id
  instance_type          = var.server_type 
  vpc_security_group_ids = ["${aws_security_group.dm_management_sg_res.id}", ]
  key_name               = var.target_keypairs
  subnet_id              = var.target_subnet

  tags = {
    Name = "${var.app_name_bastion}-Server"
  }
}

resource "aws_security_group" "dm_management_sg_res" {
  name_prefix = "Management SG"
  description = "Port Numbers On Management VPC"
  vpc_id      = data.terraform_remote_state.dm_vpc_state_ds.outputs.vpc_id_otp

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Multiple Management Ports"
  }
}

resource "aws_security_group_rule" "dm_management_sg_ssh_res" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dm_management_sg_res.id
}

resource "aws_security_group_rule" "dm_management_sg_http_res" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dm_management_sg_res.id
}

resource "aws_security_group_rule" "dm_management_egress_res" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.dm_management_sg_res.id
}


output "pub_ip" {
  value = ["${aws_instance.dm_bastion_inst_res.public_ip}"]
}