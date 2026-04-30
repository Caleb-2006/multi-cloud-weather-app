output "website_endpoint" {
  description = "The URL of the static website hosted on Azure"
  value       = azurerm_storage_account.backup.primary_web_endpoint
}