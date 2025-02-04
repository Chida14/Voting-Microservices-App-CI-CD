# Create Azure AD Group in Active Directory for AKS Admins


# data "azuread_client_config" "current" {}

resource "azuread_group" "aks_administrators" {
    display_name = "${azurerm_resource_group.aks_rg.name}-administrators"
    security_enabled = true
    description = "Azure AKS Kubernetes administrators for the ${azurerm_resource_group.aks_rg.name}-cluster."
  
}