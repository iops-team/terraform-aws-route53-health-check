# AWS Health Check Terraform Module

This Terraform module sets up health checks for specified domain names using AWS Route53, CloudWatch alarms, and SNS notifications.

## Features

- Create Route53 health checks for specified domain names with custom configurations
- Set up CloudWatch alarms for health check status
- Send notifications to specified endpoint via SNS topic when an alarm is triggered

## Usage

To use this module, first create a Terraform configuration file `example.tf` and include the module block with the desired input values:

```hcl
module "aws_health_check" {
  source = "your-source-path"

  health_checks = [
    {
      ip_address        = "1.1.1.1"
      port              = 80
      type              = "HTTP"
      resource_path     = "/"
      request_interval  = 30
      failure_threshold = 3
      tags              = { "Environment" = "prod" }
    },
    {
      fqdn              = "terraform.io"
      port              = 443
      type              = "HTTPS"
      resource_path     = "/status"
      request_interval  = 60
      failure_threshold = 2
      tags              = { "Environment" = "test" }
    }
  ]

  subscription_protocol        = "email"
  subscription_endpoint        = "you@example.com"
  confirmation_timeout_in_minutes = 5
  endpoint_auto_confirms       = true
  tags = {
    Terraform = "true"
  }
}
```

Next, initialize the Terraform working directory and apply the configuration:

```shell
$ terraform init
$ terraform apply
```

## Requirements

- Terraform >= 1.0
- AWS provider >= 4.35

## Inputs

| Name                           | Description                                                                                                                                                                                                                                                                                                                                                       | Type           | Default                        | Required |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|--------------------------------|----------|
| aws_region                     | The AWS region for the resources.                                                                                                                                                                                                                                                                                                                                 | string         | "us-east-1"                    | no       |
| comparison_operator            | The arithmetic operation to use when comparing the specified Statistic and Threshold.                                                                                                                                                                                                                                                                              | string         | "GreaterThanOrEqualToThreshold" | no       |
| confirmation_timeout_in_minutes | Integer indicating number of minutes to wait in retrying mode for fetching subscription arn before marking it as failure. Only applicable for http and https protocols. Default is 1.                                                                                                                                                                            | number         | 1                              | no       |
| endpoint_auto_confirms         | Whether the endpoint is capable of auto confirming subscription. Default is false.                                                                                                                                                                                                                                                                               | bool           | false                          | no       |
| evaluation_periods             | The number of periods over which data is compared to the specified threshold.                                                                                                                                                                                                                                                                                      | number         | 1                              | no       |
| health_checks                  | A list of health check configurations for each fqdn or ip_address. Each configuration should include:<br> - `fqdn`: (Optional) The domain name to check.<br> - `ip_address`: (Optional) The IP address to check.<br> - `port`: The port to use for the health check.<br> - `type`: The protocol to use for the health check (HTTP, HTTPS, etc.).<br> - `resource_path`: The path to request for the health check.<br> - `request_interval`: The interval between health check requests in seconds.<br> - `failure_threshold`: The number of consecutive failures required for the health check to be considered unhealthy.<br> - `tags`: A map of tags to apply to the health check resource. | list(object()) | <pre>[<br>]</pre> | yes |
| period                         | The period in seconds over which the specified statistic is applied.                                                                                                                                                                                                                                                                                              | number         | 60                             | no       |
| sns_topic_name                 | The name of the SNS topic for health check notifications.                                                                                                                                                                                                                                                                                                         | string         | "health-check-notifications"   | no       |
| statistic                      | The statistic to apply to the alarm's associated metric.                                                                                                                                                                                                                                                                                                          | string         | "Average"                      | no       |
| subscription_endpoint          | Endpoint to send data to for the SNS topic subscription.                                                                                                                                                                                                                                                                                                          | string         |                                | yes      |
| subscription_protocol          | Protocol to use for the SNS topic subscription.                                                                                                                                                                                                                                                                                                                    | string         | "email"                        | no       |
| tags                           | A map of tags to apply to all resources created by the module.                                                                                                                                                                                                                                                                                                    | map(string)    | <pre>{<br>}</pre>              | no       |
| threshold                      | The value against which the specified statistic is compared.                                                                                                                                                                                                                                                                                                      | number         | 1                              | no       |

## Outputs

| Name                        | Description                                                        |
|-----------------------------|--------------------------------------------------------------------|
| sns_topic_arn               | The ARN of the SNS topic for health check notifications.            |
| route53_health_check_ids    | A map of FQDNs to the corresponding Route 53 health check IDs.       |
| cloudwatch_metric_alarm_arns| A map of FQDN and port combinations to the corresponding CloudWatch metric alarm ARNs. |

## License

This module is released under the [MIT License](https://opensource.org/licenses/MIT).
