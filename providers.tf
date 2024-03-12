terraform {
  required_version = ">=0.12"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "1.12.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}