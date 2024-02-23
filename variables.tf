variable "aws_region" {
  description = "The AWS region for the resources."
  type        = string
  default     = "us-east-1"
}

variable "health_checks" {
  description = "A list of health check configurations for each fqdn or ip_address."
  type = list(object({
    fqdn              = optional(string)
    ip_address        = optional(string)
    port              = number
    type              = string
    resource_path     = string
    request_interval  = number
    failure_threshold = number
    tags              = map(string)
  }))
}


variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold. Additionally, the values LessThanLowerOrGreaterThanUpperThreshold, LessThanLowerThreshold, and GreaterThanUpperThreshold are used only for alarms based on anomaly detection models."
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  type        = number
  default     = "1"
}

variable "threshold" {
  description = "The value against which the specified statistic is compared."
  type        = number
  default     = "1"
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
  type        = number
  default     = "60"
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric."
  type        = string
  default     = "Average"
}

variable "subscription_protocol" {
  description = "Protocol to use for the SNS topic subscription."
  type        = string
  default     = "email"
}

variable "subscription_endpoint" {
  description = "Endpoint to send data to for the SNS topic subscription."
  type        = string
}

variable "confirmation_timeout_in_minutes" {
  description = "Integer indicating number of minutes to wait in retrying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols. Default is 1."
  type        = number
  default     = 1
}

variable "endpoint_auto_confirms" {
  description = "Whether the endpoint is capable of auto confirming subscription. Default is false."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to apply to all resources created by the module."
  type        = map(string)
  default     = {}
}

variable "sns_topic_name" {
  description = "The name of the SNS topic for health check notifications."
  type        = string
  default     = "health-check-notifications"
}
