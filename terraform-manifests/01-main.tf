# 1. Terraform Settings Block
terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.17.0" 
    }
    azuread = {
        source = "hashicorp/azuread"
        version = "~> 3.1.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }

# Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    # resource_group_name   = "aus-east-storage_account"
    # storage_account_name  = "cmandolk"
    # container_name        = "tfstatefiles"
    # key                   = "dev.terraform.tfstate"
  }
}


# 2. Terraform Provider Block for AzureRM
provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
  
}

# 3. Terraform Resource Block: Define a Random Pet Resource
resource "random_pet" "aksrandom" {
  
}