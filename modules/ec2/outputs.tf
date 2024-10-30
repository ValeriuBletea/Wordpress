output "wordpress_sg_id" {
  description = "The ID of the WordPress security group"
  value       = aws_security_group.wordpress_sg.id
}
