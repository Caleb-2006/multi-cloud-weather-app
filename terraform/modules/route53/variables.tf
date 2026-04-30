variable "domain_name" {
  description = "The primary domain name (e.g., emmanuelweather.local)"
  type        = string
}

variable "aws_endpoint" {
  description = "The AWS S3 website URL (without http://)"
  type        = string
}

variable "azure_endpoint" {
  description = "The Azure Blob Storage URL (without http://)"
  type        = string
}