locals {
  tags = {
    environment = var.environment
  }
}

resource "random_id" "random_id" {
  keepers = {
    resource_group = var.resource_group_name
  }
  byte_length = 8
}

resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = random_pet.ssh_key_name.id
  location  = var.location
  parent_id = var.resource_group_id
}

resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"
  response_export_values = ["publicKey", "privateKey"]
}

resource "azurerm_public_ip" "vm_pip" {
  name                = "${var.vm_name}_pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.vm_pip_allocation_method
  sku                 = var.vm_pip_sku
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}_nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.vm_name}_nic_config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.vm_pip_private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  size                  = var.vm_size

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.os_image_publisher
    offer     = var.os_image_offer
    sku       = var.os_image_sku
    version   = var.os_image_version
  }

  computer_name  = var.vm_name
  admin_username = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  }

  tags = local.tags
}

resource "azurerm_managed_disk" "vm_disk" {
  name                 = "${var.vm_name}_disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  tags                 = local.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.vm_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = 0
  caching            = "ReadWrite"
}

resource "azurerm_storage_account" "vm_diag" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags
}
