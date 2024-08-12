variable "location" {
  type        = string
  default     = "Central US"
  description = "resource location"
}
variable "sentinel-rg-name" {
  type        = string
  default     = "sentinel-rg"
  description = "resource group name"
}
variable "sentinel-law-name" {
  type        = string
  default     = "sentinel-law"
  description = "log analytics workspace name"
}
variable "sentinel-api-connection-name" {
  type        = string
  default     = "Sentinel-API-Connection"
  description = "API connection name"
}
variable "email-api-connection-name" {
  type        = string
  default     = "Office365-API-Connection"
  description = "email API connection name"
}
variable "api-connection-display-name" {
  type        = string
  default     = "Sentinel-api-connection"
  description = "API connection display name"
}
variable "notify-playbook-name" {
  type        = string
  default     = "Email-on-Incident"
  description = "notification playbook name"
}
variable "playbook-trigger" {
  type        = string
  default     = "trigger-on-sentinel-incident"
  description = "playbook trigger name"
}
variable "uuidnamespace" {
  type        = string
  default     = "CN=SentinelAutomationRule,C=US"
  description = "namespace to generate a uuid"
}
