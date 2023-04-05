output "sg_arn" {
  description = "The ARN of the security group"
  value       = aws_security_group.security_group.arn
}

output "sg_id" {
  description = "The ID of the security group"
  value       = aws_security_group.security_group.id
}

output "sg_owner_id" {
  description = "The Owner ID of the security group"
  value       = aws_security_group.security_group.owner_id 
  }
