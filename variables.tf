variable "resource_group_name" {
  description = "The name of the resource group."
}

variable "location" {
  description = "The Azure location where the resources will be created."
}

variable "subnet_id" {
  description = "The ID of the subnet for the VM."
}

variable "vm_name" {
  description = "The name of the virtual machine."
}

variable "vm_size" {
  description = "The size of the virtual machine."
}

variable "admin_username" {
  description = "The admin username for the virtual machine."
}

variable "resource_group_id" {
  description = "The resource ID of the resource group."
}

variable "disk_size_gb" {
  description = "The size of the managed disk in GB."
}

variable "environment" {
  description = "The environment for the resources."
  default     = "production"
  
}

variable "vm_pip_allocation_method" {
  description = "The allocation method for the public IP."
  type        = string
  default     = "Static"
  
}

variable "vm_pip_sku" {
  description = "The SKU for the public IP."
  type        = string
  default     = "Standard"
  
}

variable "vm_pip_private_ip_address_allocation" {
  description = "The allocation method for the private IP address."
  type        = string
  default     = "Dynamic"
  
}

variable "os_image_publisher" {
  description = "The publisher of the OS image."
  type        = string
  default     = "Canonical"
  
}

variable "os_image_offer" {
  description = "The offer of the OS image."
  type        = string
  default     = "UbuntuServer"
  
}

variable "os_image_sku" {
  description = "The SKU of the OS image."
  type        = string
  default     = "18.04-LTS"
  
}

variable "os_image_version" {
  description = "The version of the OS image."
  type        = string
  default     = "latest"
  
}