
output "sns_topic_arn" {
  value = module.route53_health_check.sns_topic_arn
}

output "route53_health_check_ids" {
  value = module.route53_health_check.route53_health_check_ids
}

output "cloudwatch_metric_alarm_arns" {
  value = module.route53_health_check.cloudwatch_metric_alarm_arns
}
