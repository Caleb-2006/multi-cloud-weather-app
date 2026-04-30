output "website_endpoint" {
  description = "The URL of the static website hosted on S3"
  value       = aws_s3_bucket_website_configuration.weather_app_website.website_endpoint
}