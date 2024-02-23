
output "sns_topic_arn" {
  description = "The ARN of the SNS topic for health check notifications."
  value       = module.route53_health_check.sns_topic_arn
}

output "route53_health_check_ids" {
  description = "A map of FQDNs to the corresponding Route 53 health check IDs."
  value       = module.route53_health_check.route53_health_check_ids
}

output "cloudwatch_metric_alarm_arns" {
  description = "A map of FQDNs/IP addresses and ports to the corresponding CloudWatch Metric Alarm ARNs."
  value       = module.route53_health_check.cloudwatch_metric_alarm_arns
}
