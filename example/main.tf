module "route53_health_check" {
  source = "iops-team/route53-health-check/aws"

  health_checks = [
    {
      ip_address        = "1.1.1.1"
      port              = 80
      type              = "HTTP"
      resource_path     = "/"
      request_interval  = 30
      failure_threshold = 3
      tags              = { "Name" = "CloudFlare" }

    },
    {
      fqdn              = "terraform.io"
      port              = 443
      type              = "HTTPS"
      resource_path     = "/status"
      request_interval  = 30
      failure_threshold = 5
      tags              = { "Name" = "Terraform" }
    }
  ]
  subscription_endpoint = "you@example.com"
  tags = {
    "Terraform" = "true"
  }
}
