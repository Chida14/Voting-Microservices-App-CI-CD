# Define Input Variables
# 1. Azure Location (CentralUS)
# 2. Azure Resource Group Name 
# 3. Azure AKS Environment Name (Dev, QA, Prod)

variable "subscription_id" {
  # we can pass the sun_id as an environment variable TF_VAR_subscription_id
  # cmd is :- export TF_VAR_subscription_id="<sub_id>"
  # if you want to delete the env var use: unset TF_VAR_subscription_id
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  default = "Australia East"
  description = "This is the location where all the resources will be created"
  type = string
}

# Azure Resource Group Name
variable "resource_group_name" {
  type = string
  description = "This variable defines the Resource Group"
  default = "terraform-aks"
}

# Azure AKS Environment Name
variable "environment" {
  type = string  
  description = "This variable defines the Environment"  
  # default = "dev"
}

# SSH Public Key for Linux VMs
variable "ssh_public_key" {
  # default = "~/.ssh/aks-prod-sshkeys-terraform/aksprodsshkey.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}

# Windows Admin Username for k8s worker nodes
variable "windows_admin_username" {
  type = string
  default = "azureuser"
  description = "This variable defines the Windows admin username k8s Worker nodes"  
}

# Windows Admin Password for k8s worker nodes
variable "windows_admin_password" {
  type = string
  default = "StackSimplify@102"
  description = "This variable defines the Windows admin password k8s Worker nodes"  
}