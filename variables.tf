variable "Name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = "string"
}

variable "Environment" {
  type        = "string"
  description = "Environment (e.g. `prod`, `dev`, `staging`)"
}

variable "CreatedBy" {
  type        = "string"
  description = "CreatedBy (e.g. `terraform`, `dev`, `devops`)"
}

variable "Organization" {
  type        = "string"
  description = "Organization (e.g. `bac`, `cd`)"
}

variable "availability_zones" {
  type        = "list"
  default     = []
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)"
}

variable "max_subnets" {
  default     = "6"
  description = "Maximum number of subnets that can be created. The variable is used for CIDR blocks calculation"
}

variable "type" {
  type        = "string"
  default     = "private"
  description = "Type of subnets to create (`private` or `public`)"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID"
}

variable "cidr_block" {
  type        = "string"
  description = "Base CIDR block which is divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)"
}

variable "igw_id" {
  type        = "string"
  description = "Internet Gateway ID that is used as a default route when creating public subnets (e.g. `igw-9c26a123`)"
  default     = ""
}


variable "public_network_acl_id" {
  type        = "string"
  description = "Network ACL ID that is added to the public subnets. If empty, a new ACL will be created"
  default     = ""
}


variable "public_network_acl_egress" {
  description = "Egress network ACL rules"
  type        = "list"

  default = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
  ]
}

variable "public_network_acl_ingress" {
  description = "Egress network ACL rules"
  type        = "list"

  default = [
    {
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
    },
  ]
}

variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  default     = "true"
}
