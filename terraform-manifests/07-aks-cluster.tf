# Provision AKS Cluster
/*
1. Add Basic Cluster Settings
  - Get Latest Kubernetes Version from datasource (kubernetes_version)
  - Add Node Resource Group (node_resource_group)
2. Add Default Node Pool Settings
  - orchestrator_version (latest kubernetes version using datasource)
  - availability_zones
  - enable_auto_scaling
  - max_count, min_count
  - os_disk_size_gb
  - type
  - node_labels
  - tags
3. Enable MSI
4. Add On Profiles 
  - Azure Policy
  - Azure Monitor (Reference Log Analytics Workspace id)
5. RBAC & Azure AD Integration
6. Admin Profiles
  - Windows Admin Profile
  - Linux Profile
7. Network Profile
8. Cluster Tags  
*/


resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${azurerm_resource_group.aks_rg.name}-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${azurerm_resource_group.aks_rg.name}-cluster"
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"

  default_node_pool {
    name       = "systempool"
    # node_count = 1
    vm_size    = "Standard_DS2_v2"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    zones = [1, 2, 3]
    auto_scaling_enabled = true
    max_count = 2
    min_count = 1
    os_disk_size_gb = 30
    type = "VirtualMachineScaleSets"
    node_labels = {
      "nodepool-type" = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
    }
    tags = {
      "nodepool-type" = "system"
      "environment"      = "dev"
      "nodepoolos"       = "linux"
      "app"              = "system-apps" 
    }
  }

# Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

# Add On
oms_agent {
  log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
}

azure_active_directory_role_based_access_control {
  admin_group_object_ids = [azuread_group.aks_administrators.object_id]
}

# Windows Profile
windows_profile {
  admin_username = var.windows_admin_username
  admin_password = var.windows_admin_password
}

# Linux Profile
linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
}

# Network Profile
network_profile {
  network_plugin = "azure"
  load_balancer_sku = "standard"
}

  tags = {
    Environment = "dev"
  }
}