variable "root_id" {
  type        = string
  description = "Sets the value used for generating unique resource naming within the module."
  default     = "alz"
}

variable "root_name" {
  type        = string
  description = "Sets the name for the root management group."
  default     = "Appvia"
}

variable "connectivity_storage_account_name" {
  type        = string
  description = "Sets the name of the storage account to retrieve the connectivity configuration from"
}

variable "management_storage_account_name" {
  type        = string
  description = "Sets the name of the storage account to retrieve the management configuration from"
}

variable "identity_storage_account_name" {
  type        = string
  description = "Sets the name of the storage account to retrieve the identity configuration from"
}

variable "state_subscription_id" {
  type        = string
  description = "The subscription ID of the state subscription"
}

variable "use_oidc" {
  type        = bool
  description = "Use OpenID Connect to authenticate to AzureRM"
  default     = false
}

variable "rbac_template_name" {
  type        = string
  description = "Sets the RBAC template name to use for the deployment"
  default     = "standard"

  validation {
    condition     = can(regex("^(standard|basic)$", var.rbac_template_name))
    error_message = "RBAC template name must be either 'standard' or 'basic'"
  }
}

variable "primary_location" {
  type        = string
  description = "Sets the value used for the primary location of resources within the module."
  default     = "uksouth"
}
