variable "security_group_rule" {
  description = "Security group rules"
  type        = any
  default     = []
}

variable "security_group_id" {
  description = "The id of the security group"
  type        = string
  default     = null
}
