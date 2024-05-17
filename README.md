
<!-- BEGIN_TF_DOCS -->
# ALZ.Core
This project deploys all the core governance controls for working within Azure.  It lays out the management group hierarchy as well as applies all of the Azure Policy and Role Based Access Controls to the management groups.

It is implemented using the Microsoft ALZ terraform module https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki

# Updating Policies

Policies can be asssigned / customised in the the `terraform/lib` folder. Comprehensive documentation for customising policy can be found here: https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Create-Custom-Policies-Policy-Sets-and-Assignments

# Updating the Management Group Hierarchy

Additional landing zone management groups can be added into the hierarchy by editing `custom_landing_zones` in `main.tf`.  Comprehensive documentation on editing the hierarchy can be found here: https://github.com/Azure/terraform-azurerm-caf-enterprise-scale/wiki/%5BExamples%5D-Deploy-Custom-Landing-Zone-Archetypes

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connectivity_storage_account_name"></a> [connectivity\_storage\_account\_name](#input\_connectivity\_storage\_account\_name) | Sets the name of the storage account to retrieve the connectivity configuration from | `string` | n/a | yes |
| <a name="input_identity_storage_account_name"></a> [identity\_storage\_account\_name](#input\_identity\_storage\_account\_name) | Sets the name of the storage account to retrieve the identity configuration from | `string` | n/a | yes |
| <a name="input_management_storage_account_name"></a> [management\_storage\_account\_name](#input\_management\_storage\_account\_name) | Sets the name of the storage account to retrieve the management configuration from | `string` | n/a | yes |
| <a name="input_primary_location"></a> [primary\_location](#input\_primary\_location) | Sets the value used for the primary location of resources within the module. | `string` | `"uksouth"` | no |
| <a name="input_rbac_template_name"></a> [rbac\_template\_name](#input\_rbac\_template\_name) | Sets the RBAC template name to use for the deployment | `string` | `"standard"` | no |
| <a name="input_root_id"></a> [root\_id](#input\_root\_id) | Sets the value used for generating unique resource naming within the module. | `string` | `"alz"` | no |
| <a name="input_root_name"></a> [root\_name](#input\_root\_name) | Sets the name for the root management group. | `string` | `"Appvia"` | no |
| <a name="input_state_subscription_id"></a> [state\_subscription\_id](#input\_state\_subscription\_id) | The subscription ID of the state subscription | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_private_dns_zone"></a> [azurerm\_private\_dns\_zone](#output\_azurerm\_private\_dns\_zone) | Returns the configuration data for all Private DNS Zones created by ALZ. |
| <a name="output_azurerm_virtual_hub_ids"></a> [azurerm\_virtual\_hub\_ids](#output\_azurerm\_virtual\_hub\_ids) | Returns the IDs of all Virtual Hubs that have been created. |
| <a name="output_azurerm_virtual_network"></a> [azurerm\_virtual\_network](#output\_azurerm\_virtual\_network) | Returns the Virtual Networks that have been created by ALZ. |
| <a name="output_subscription_connectivity"></a> [subscription\_connectivity](#output\_subscription\_connectivity) | Returns the ID of the Connectivity subscription. |
| <a name="output_subscription_identity"></a> [subscription\_identity](#output\_subscription\_identity) | Returns the ID of the Identity subscription. |
| <a name="output_subscription_management"></a> [subscription\_management](#output\_subscription\_management) | Returns the ID of the Management subscription. |
<!-- END_TF_DOCS -->