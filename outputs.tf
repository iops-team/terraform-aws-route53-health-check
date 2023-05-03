output "sns_topic_arn" {
  description = "The ARN of the SNS topic for health check notifications."
  value       = aws_sns_topic.health_check_notifications.arn
}

output "route53_health_check_ids" {
  description = "A map of FQDNs to the corresponding Route 53 health check IDs."
  value       = { for k, v in aws_route53_health_check.example : k => v.id }
}

output "cloudwatch_metric_alarm_arns" {
  value = { for k, v in aws_cloudwatch_metric_alarm.health_check_alarm : "${k} ${aws_route53_health_check.example[k].port}" => v.arn }
}