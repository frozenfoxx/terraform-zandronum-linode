variable "authorized_keys" {
  default     = [""]
  description = "List of public keys used for SSH connections"
}

variable "config" {
  default     = ""
  description = "Zandronum server configuration, base64 encoded"
}

variable "image" {
  default     = "linode/ubuntu20.04"
  description = "Image used for deployment"
}

variable "group" {
  default     = "zandronum"
  description = "Display group"
}

variable "name" {
  default     = "zandronum"
  description = "Hostname of the system"
}

variable "options" {
  default = ""
  description = "String of options to pass to the server"
}

variable "private_key" {
  default     = ""
  description = "Private SSH key for the root user"
}

variable "region" {
  default     = "us-central"
  description = "Region to clone in"
}

variable "root_pass" {
  default     = ""
  description = "Password for the persistent user"
}

variable "tags" {
  default     = [ "games" ]
  description = "Tags to apply"
}

variable "type" {
  default     = "g6-nanode-1"
  description = "Type of instance"
}
