module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "5.0.3"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id   = data.azurerm_client_config.current.tenant_id
  root_id          = var.root_id
  root_name        = var.root_name
  default_location = var.primary_location
  library_path     = "${path.root}/lib"

  strict_subscription_association = false

  deploy_core_landing_zones = true

  deploy_identity_resources    = false
  configure_identity_resources = data.terraform_remote_state.identity.outputs.configuration
  subscription_id_identity     = data.terraform_remote_state.identity.outputs.subscription_id

  deploy_connectivity_resources    = false
  configure_connectivity_resources = data.terraform_remote_state.connectivity.outputs.configuration
  subscription_id_connectivity     = data.terraform_remote_state.connectivity.outputs.subscription_id

  deploy_management_resources    = false
  configure_management_resources = data.terraform_remote_state.management.outputs.configuration
  subscription_id_management     = data.terraform_remote_state.management.outputs.subscription_id

  custom_landing_zones = {
    (var.root_id) = {
      display_name               = var.root_name
      parent_management_group_id = data.azurerm_client_config.current.tenant_id
      subscription_ids           = []
      archetype_config = {
        archetype_id = "es_root"
        parameters = {
          "Deploy-Diagnostics-AKS" = {
            "logAnalytics" = data.terraform_remote_state.management.outputs.log_analytics_workspace_ids[0]
          }
        }
        access_control = {}
      }
    }
    "${var.root_id}-hub" = {
      display_name               = "Hub"
      parent_management_group_id = var.root_id
      subscription_ids           = []
      archetype_config = {
        archetype_id = "hub"
        parameters = {
          Enable-LA-Agent-AutoPrvn = {
            logAnalytics = data.terraform_remote_state.management.outputs.log_analytics_workspace_ids[0]
          }
          Deploy-SubActivityAlerts = {
            actionGroupResourceId = data.terraform_remote_state.management.outputs.action_group_id
          }
        }
        access_control = {}
      }
    }
    "${var.root_id}-landing-zones" = {
      display_name               = "Landing Zones"
      parent_management_group_id = "${var.root_id}-hub"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "es_landing_zones"
        parameters = {
          Deny-Subnet-Without-Nsg = {
            effect = "Audit"
          }
        }
        access_control = {}
      }
    }
    "${var.root_id}-platform" = {
      display_name               = "Platform"
      parent_management_group_id = "${var.root_id}-hub"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_platform"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-internal" = {
      display_name               = "Internal"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-external" = {
      display_name               = "External"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "external"
        parameters     = {}
        access_control = {}
      }
    }
  }
}

module "rbac" {
  # tflint-ignore: terraform_module_pinned_source
  source = "git::https://github.com/alztestappvia/alz_tfmod_rbac?ref=main"

  providers = {
    azurerm = azurerm
    azuread = azuread
    azapi   = azapi
    time    = time
  }

  rbac_type     = "platform"
  template_name = var.rbac_template_name

  nested_groups_map = {
    platform_engineers = []
    network_engineers  = []
    security_engineers = []
  }

  depends_on = [
    module.enterprise_scale.azurerm_management_group
  ]
}

resource "azurerm_management_group_subscription_association" "state" {
  management_group_id = "/providers/Microsoft.Management/managementGroups/${var.root_id}-platform"
  subscription_id     = "/subscriptions/${var.state_subscription_id}"
}
