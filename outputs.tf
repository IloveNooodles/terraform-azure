output "instance1_id" {
  value = azurerm_virtual_machine.vm["1"].id
}

output "instance1_internal_ip" {
  value = azurerm_network_interface.detail["1"].ip_configuration[0].private_ip_address
}

output "instance1_public_ip" {
  value = azurerm_public_ip.detail["1"].ip_address
}

output "instance2_id" {
  value = azurerm_virtual_machine.vm["2"].id
}

output "instance2_internal_ip" {
  value = azurerm_network_interface.detail["2"].ip_configuration[0].private_ip_address
}

output "instance2_public_ip" {
  value = azurerm_public_ip.detail["2"].ip_address
}

output "instance3_id" {
  value = azurerm_virtual_machine.vm["3"].id
}

output "instance3_internal_ip" {
  value = azurerm_network_interface.detail["3"].ip_configuration[0].private_ip_address
}

output "instance3_public_ip" {
  value = azurerm_public_ip.detail["3"].ip_address
}

output "instance4_id" {
  value = azurerm_virtual_machine.vm["4"].id
}

output "instance4_internal_ip" {
  value = azurerm_network_interface.detail["4"].ip_configuration[0].private_ip_address
}

output "instance4_public_ip" {
  value = azurerm_public_ip.detail["4"].ip_address
}
