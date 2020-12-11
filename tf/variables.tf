variable "image_id" {
  description = "instance image id"
  type        = string
}

variable "flavor" {
  description = "flavor"
  type        = string
}

variable "network_uuid" {
  description = "id of network to connect to"
  type        = string
}

variable "network_name" {
  description = "name of network to connect to"
  type        = string
}

variable "dns_zone_name" {
  type = string
}

variable "dns_zone_uuid" {
  type    = string
}

variable "floating_ip_pool" {
  type    = string
}

variable "name_prefix" {
  description = "Specify the server name prefix"
  type        = list
}

variable "volume_size" {
  description = "Specify size of volume has to be attached to the instance."
  type        = string
}

variable "instances_count" {
  description = "Number of servers"
  type        = string
}

variable "ssh_user_name" {
  type    = string
}

variable "key_pair" {
  description = "Key name for accessing instances through ssh"
}

variable "key_file_path" {
  description = "Private key for accessing instances through ssh"
}

variable "availability_zone" {
  description = "Specify the availability zones"
  type        = string
}

variable "security_groups" {
  description = "Security groups found in monsoon3 networking"
  type    = list(string)
  default = ["default"]
}