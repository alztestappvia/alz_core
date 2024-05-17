output "azurerm_virtual_hub_ids" {
  description = "Returns the IDs of all Virtual Hubs that have been created."
  value       = data.terraform_remote_state.connectivity.outputs.azurerm_virtual_hub_ids
}

output "subscription_identity" {
  description = "Returns the ID of the Identity subscription."
  value       = data.terraform_remote_state.identity.outputs.subscription_id
}

output "subscription_connectivity" {
  description = "Returns the ID of the Connectivity subscription."
  value       = data.terraform_remote_state.connectivity.outputs.subscription_id
}

output "subscription_management" {
  description = "Returns the ID of the Management subscription."
  value       = data.terraform_remote_state.management.outputs.subscription_id
}

output "azurerm_private_dns_zone" {
  description = "Returns the configuration data for all Private DNS Zones created by ALZ."
  value       = data.terraform_remote_state.connectivity.outputs.azurerm_private_dns_zone
}

output "azurerm_virtual_network" {
  description = "Returns the Virtual Networks that have been created by ALZ."
  value       = try(data.terraform_remote_state.connectivity.outputs.azurerm_virtual_network, {})
}
