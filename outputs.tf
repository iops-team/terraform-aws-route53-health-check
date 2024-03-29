output "sns_topic_arn" {
  description = "The ARN of the SNS topic for health check notifications."
  value       = aws_sns_topic.health_check_notifications.arn
}

output "route53_health_check_ids" {
  description = "A map of FQDNs to the corresponding Route 53 health check IDs."
  value       = { for k, v in aws_route53_health_check.this : k => v.id }
}

output "cloudwatch_metric_alarm_arns" {
  description = "A map of FQDNs/IP addresses and ports to the corresponding CloudWatch Metric Alarm ARNs."
  value       = { for k, v in aws_cloudwatch_metric_alarm.health_check_alarm : "${k} ${v.dimensions.HealthCheckId}" => v.arn }
}
