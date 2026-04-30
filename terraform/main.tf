module "aws_frontend" {
  source      = "./modules/aws_s3"
  # Update this line to match the domain exactly
  bucket_name = "www.emmanuelbuilds.space" 
}

module "azure_backup" {
  source               = "./modules/azure_blob"
  storage_account_name = "emmanuelweatherbackup26"
}

module "dns_routing" {
  source         = "./modules/route53"
  domain_name    = "emmanuelbuilds.space" 
  aws_endpoint   = module.aws_frontend.website_endpoint
  azure_endpoint = module.azure_backup.website_endpoint
}

# 1. Create an empty bucket for the naked domain
resource "aws_s3_bucket" "naked_domain_redirect" {
  bucket = "emmanuelbuilds.space"
}

# 2. Tell the bucket to bounce all traffic to your www site
resource "aws_s3_bucket_website_configuration" "redirect_config" {
  bucket = aws_s3_bucket.naked_domain_redirect.id

  redirect_all_requests_to {
    host_name = "www.emmanuelbuilds.space"
    protocol  = "http"
  }
}

# 3. Create the Route 53 traffic rule for the naked domain
resource "aws_route53_record" "naked_domain_record" {
  zone_id = "Z05028571WPZV3AETIWY4" 
  name    = "emmanuelbuilds.space"
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.redirect_config.website_domain
    zone_id                = aws_s3_bucket.naked_domain_redirect.hosted_zone_id
    evaluate_target_health = false
  }
}