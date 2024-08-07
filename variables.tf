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
variable "email-to" {
  type        = string
  default     = "PreferredDistroGroup@email.tld"
  description = "distribution group email address"
}
variable "email-subject" {
  type        = string
  default     = "Microsoft Sentinel Notification System"
  description = "email subject"
}
variable "email-body" {
  type        = string
  default     = "<p class=\"editor-paragraph\">Good day,</p><p class=\"editor-paragraph\"></p><br><p class=\"editor-paragraph\">Please review &lt;AzureTenant&gt; for new alerts.</p><p class=\"editor-paragraph\"></p><br><p class=\"editor-paragraph\">Sincerely,</p><p class=\"editor-paragraph\"></p><br><p class=\"editor-paragraph\">Microsoft Sentinel</p>"
  description = "email body"
}
variable "email-importance" {
  type        = string
  default     = "High"
  description = "email importance flag"
}
