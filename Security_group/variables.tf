variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = null
}

variable "security_group_name_prefix" {
  description = "The name of the security group"
  type        = string
  default     = null
}

variable "security_group_description" {
  description = "The description of the security group"
  type        = string
  default     = null
}

variable "ingress" {
  description = "Security group ingress rules"
  type        = any
  default     = []
}

variable "egress" {
  description = "Security group egress rules"
  type        = any
  default     = []
}

variable "vpc_id" {
  description = "The vpc id used for creating the security group"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
