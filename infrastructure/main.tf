# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.2.0"  
    }
  }
  backend "azurerm" {}  
  required_version = ">= 1.0.0"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # Adicionar o resource_provider_registrations se necessário
  # resource_provider_registrations = "none"
}

# Mantive os data sources que você estava usando
data "azurerm_client_config" "current" {}

data "http" "ip" {
  url = "https://ifconfig.me"
}


# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "Brazil South"  # Ajustado para a localização que você mencionou
# }

# resource "azurerm_virtual_network" "example" {
#   name                = "example-network"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   address_space       = ["10.0.0.0/16"]
# }