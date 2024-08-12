#Creating resource group for Sentinel
resource "azurerm_resource_group" "mainrg" {
  name     = var.sentinel-rg-name
  location = var.location
}
#Create the analytic Workspace
resource "azurerm_log_analytics_workspace" "mainlaw" {
  name                = var.sentinel-law-name
  location            = azurerm_resource_group.mainrg.location
  resource_group_name = azurerm_resource_group.mainrg.name
  sku                 = "PerGB2018"
}
#Create the Analytic Solution
resource "azurerm_log_analytics_solution" "mainlas" {
  solution_name         = "SecurityInsights"
  location              = azurerm_resource_group.mainrg.location
  resource_group_name   = azurerm_resource_group.mainrg.name
  workspace_resource_id = azurerm_log_analytics_workspace.mainlaw.id
  workspace_name        = azurerm_log_analytics_workspace.mainlaw.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}
#Onboard the Analytics workspace to Sentinel
resource "azurerm_sentinel_log_analytics_workspace_onboarding" "lawonboarding" {
  workspace_id                 = azurerm_log_analytics_workspace.mainlaw.id
  customer_managed_key_enabled = false
}
#######################################################
#Create the Azure Sentinel Playbook, Microsot Sentinel Incident Trigger, API Connections, and Permissions
data "azurerm_managed_api" "smapi" {
  name     = "azuresentinel"
  location = azurerm_resource_group.mainrg.location
}
#Create the API for Sentinel Trigger
resource "azurerm_api_connection" "sapiconnection" {
  name                = var.sentinel-api-connection-name
  resource_group_name = azurerm_resource_group.mainrg.name
  managed_api_id      = data.azurerm_managed_api.smapi.id
  display_name        = var.sentinel-api-connection-name
}
#Create Automation Playbook
resource "azurerm_logic_app_workflow" "EmailNotify" {
  name                = var.notify-playbook-name
  location            = azurerm_resource_group.mainrg.location
  resource_group_name = azurerm_resource_group.mainrg.name
  enabled = "true"
  parameters = {
    "$connections" = jsonencode(
      {
        azuresentinel = {
          connectionId   = azurerm_api_connection.sapiconnection.id
          connectionName = azurerm_api_connection.sapiconnection.name
          id             = data.azurerm_managed_api.smapi.id
        },
        office365 = {
          connectionId   = azurerm_api_connection.eapiconnection.id
          connectionName = azurerm_api_connection.eapiconnection.name
          id             = data.azurerm_managed_api.emapi.id
        }
      }
    )
  }
  workflow_parameters = {
    "$connections" = jsonencode(
      {
        defaultValue = {}
        type = "Object"
      }
    )
  }
}
#Create Sentinel Playbook Trigger
resource "azurerm_logic_app_trigger_custom" "msitrigger" {
  name         = "Microsoft_Sentinel_incident"
  logic_app_id = azurerm_logic_app_workflow.EmailNotify.id

  body = jsonencode(
    {
      type = "ApiConnectionWebhook",
      inputs = {
        host = {
          connection = {
            referenceName = data.azurerm_managed_api.smapi.name
          }
        },
        path = "/incident-creation"
      }
    }
  )
}
#Create Sentinel Playbook Action
resource "azurerm_logic_app_action_custom" "emailnotifyaction" {
  name         = "Send_an_email_(V2)"
  logic_app_id = azurerm_logic_app_workflow.EmailNotify.id
  body         = file("${path.module}/emailnotify.json")
}
#Get Service Prinicpal attributes
data "azuread_service_principal" "AzureSecurityInsights" {
  display_name = "Azure Security Insights"
}
#Gives permission to the Service Principal to have permissions to playbooks within the Resource Group
resource "azurerm_role_assignment" "sentinelautomationpermissions" {
  scope                = azurerm_resource_group.mainrg.id
  role_definition_name = "Microsoft Sentinel Automation Contributor"
  principal_id         = data.azuread_service_principal.AzureSecurityInsights.object_id
}
#Create Sentinel Automation Rule that leverages the playbook
resource "azurerm_sentinel_automation_rule" "emailnotifyrule" {
  name                       = uuidv5("x500", var.uuidnamespace)
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.lawonboarding.workspace_id
  display_name               = "Email on Incident Creation"
  order                      = 1
  triggers_on = "Incidents"
  action_playbook {
    logic_app_id = azurerm_logic_app_workflow.EmailNotify.id
    order = 1
  }
}
