resource "aws_security_group_rule" "security_group_rule" {
      count                              = length(var.security_group_rule) 
      type      = lookup(var.security_group_rule[count.index], "type", null)
      description      = lookup(var.security_group_rule[count.index], "description", null)
      from_port        = lookup(var.security_group_rule[count.index], "from_port", null)
      to_port          = lookup(var.security_group_rule[count.index], "to_port", null)
      protocol         = lookup(var.security_group_rule[count.index], "protocol", null)
      cidr_blocks      = lookup(var.security_group_rule[count.index], "cidr_blocks", null)
      ipv6_cidr_blocks = lookup(var.security_group_rule[count.index], "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(var.security_group_rule[count.index], "prefix_list_ids", null)
      source_security_group_id  = lookup(var.security_group_rule[count.index], "source_security_group_id", null)
      self             = lookup(var.security_group_rule[count.index], "self", null)
      security_group_id = var.security_group_id
}
