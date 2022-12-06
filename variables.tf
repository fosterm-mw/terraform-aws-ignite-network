
variable "vpc_name" {
  type = string
  description = "Name of the vpc network"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
  description = "CIDR range for new vpc"
}

variable "public_cidr" {
  type = string
  default = "10.0.0.128/26"
  description = "CIDR range for public subnet"
}

variable "private_cidr" {
  type = string
  default = "10.0.0.192/26"
  description = "CIDR range for private subnet"
}

variable "private_failover_cidr" {
  type = string
  default = "10.0.2.0/24"
  description = "CIDR range for private failover subnet"
}

