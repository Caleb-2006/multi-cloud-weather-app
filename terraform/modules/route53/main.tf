resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

resource "aws_route53_health_check" "aws_health" {
  fqdn              = var.aws_endpoint
  port              = 80
  type              = "HTTP"
  resource_path     = "/index.html"
  failure_threshold = "3"
  request_interval  = "30"
}

resource "aws_route53_record" "main_aws" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = 60

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier  = "aws-primary"
  records         = [var.aws_endpoint]
  health_check_id = aws_route53_health_check.aws_health.id
}

resource "aws_route53_record" "failover_azure" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = 60

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "azure-backup"
  records        = [var.azure_endpoint]
}