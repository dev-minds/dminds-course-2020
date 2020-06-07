variable "profile_name" {
  default     = ""
  description = "Specify Profile"
}

variable "aws_region" {
  default     = ""
  description = "Specify Region"
}


variable "app_name_bastion" {
  default     = ""
  description = "Specify Region"
}

variable "aws_ami" {
  default     = ""
  description = "Currently stuck with centos 7:centos user"
}

variable "server_type" {
  default     = ""
  description = "Medium size servers"
}

variable "target_keypairs" {
  default     = ""
  description = "DevMinds default keys: dm-kliuch"
}

variable "target_subnet" {
  default     = ""
  description = "DevMinds Default VPC SN: eu-west-1a"
}

variable "server_count" {
  default     = "1"
  description = "Number of instances to create"
}