resource "azurerm_resource_group" "backup_rg" {
  name     = "weather-app-backup-rg"
  location = "East US"
}

resource "azurerm_storage_account" "backup" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.backup_rg.name
  location                 = azurerm_resource_group.backup_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  static_website {
    index_document = "index.html"
  }
}