variable "location" {
  type = string
  default = "Central US"
}
variable "sentinel-rg-name" {
  type = string
  default = "sentinel-rg"
}
variable "sentinel-law-name" {
  type = string
  default = "sentinel-law"
}
variable "sentinel-api-connection-name" {
  type = string
  default = "Sentinel-API-Connection"
}
variable "email-api-connection-name" {
  type = string
  default = "Office365-API-Connection"
}
variable "api-connection-display-name" {
  type = string
  default = "Sentinel-learn-api-connection"
}
variable "notify-playbook-name" {
  type = string
  default = "Email-on-Incident"
}
variable "playbook-trigger" {
  type = string
  default = "trigger-on-sentinel-incident"
}
variable "email-to"{
  type = string
  default = "PreferredDistroGroup@email.tld"
}
variable "email-subject" {
  type = string
  default = "Microsoft Sentinel Notification System"
}
variable "email-body" {
  type = string
  default = "<p class=\"editor-paragraph\">Good day,</p><p class=\"editor-paragraph\"></p><br><p class=\"editor-paragraph\">Please review &lt;AzureTenant&gt; for new alerts.</p><p class=\"editor-paragraph\"></p><br><p class=\"editor-paragraph\">Sincerely,</p><p class=\"editor-paragraph\"></p><br><p class=\"editor-paragraph\">Microsoft Sentinel</p>"
}
variable "email-importance" {
  type = string
  default = "High"
}