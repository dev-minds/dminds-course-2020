variable "pub_ip_range" {
  description = "Specifies sb range "
  default     = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable "pub_azs" {
  description = "Specifies AZs"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}