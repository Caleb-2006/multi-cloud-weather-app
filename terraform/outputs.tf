output "aws_live_url" {
  description = "The live URL for the AWS S3 website"
  value       = module.aws_frontend.website_endpoint
}

output "azure_live_url" {
  description = "The live URL for the Azure Blob website"
  value       = module.azure_backup.website_endpoint
}