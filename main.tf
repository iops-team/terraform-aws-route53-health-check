provider "aws" {
  region = var.aws_region
}

resource "aws_sns_topic" "health_check_notifications" {
  name = var.sns_topic_name
  tags = var.tags
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn                       = aws_sns_topic.health_check_notifications.arn
  protocol                        = var.subscription_protocol
  endpoint                        = var.subscription_endpoint
  confirmation_timeout_in_minutes = var.confirmation_timeout_in_minutes
  endpoint_auto_confirms          = var.endpoint_auto_confirms
}

resource "aws_route53_health_check" "example" {
  for_each = { for hc in var.health_checks : hc.fqdn != null ? hc.fqdn : hc.ip_address => hc }

  fqdn              = each.value.fqdn != null ? each.value.fqdn : ""
  ip_address        = each.value.ip_address != null ? each.value.ip_address : null
  port              = each.value.port
  type              = each.value.type
  resource_path     = each.value.resource_path
  request_interval  = each.value.request_interval
  failure_threshold = each.value.failure_threshold
  tags              = each.value.tags
}


resource "aws_cloudwatch_metric_alarm" "health_check_alarm" {
  for_each = aws_route53_health_check.example

  alarm_name          = "${each.value.fqdn != "" ? each.value.fqdn : each.value.ip_address}-${each.value.port}-health-check-alarm"
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_description   = "This metric checks the health of ${each.value.fqdn}"
  alarm_actions       = [aws_sns_topic.health_check_notifications.arn]
  dimensions = {
    HealthCheckId = each.value.id
  }
  tags = each.value.tags
}
