output "region" {
  description = "AWS region"
  value       = var.region
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}