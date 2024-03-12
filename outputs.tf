output "public_ip_address" {
  value = azurerm_public_ip.vm_pip.ip_address
}

output "ssh_public_key" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
}

output "ssh_private_key" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).privateKey
}
