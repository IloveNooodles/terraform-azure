resource "azurerm_virtual_machine" "vm" {
  for_each = {
    "1" = "server-1"
    "2" = "server-2"
    "3" = "server-3"
    "4" = "server-4"
  }

  name                             = "terraform-managed-instance-${each.key}"
  resource_group_name              = azurerm_resource_group.detail.name
  location                         = azurerm_resource_group.detail.location
  vm_size                          = "Standard_B1s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  dynamic "storage_image_reference" {
    for_each = [each.value]
    content {
      offer     = "0001-com-ubuntu-server-focal"
      publisher = "Canonical"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
  }

  dynamic "storage_os_disk" {
    for_each = [each.value]
    content {
      name              = "os-disk-${each.key}"
      caching           = "ReadWrite"
      create_option     = "FromImage"
      managed_disk_type = "Standard_LRS"
    }
  }

  os_profile {
    computer_name  = "vm-${each.key}"
    admin_username = "adminadmin"
    admin_password = "passwordpasswordpassword"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_interface_ids = [azurerm_network_interface.detail[each.key].id]

  tags = {
    environment = "development"
  }
}

resource "azurerm_network_interface" "detail" {
  for_each = {
    "1" = "",
    "2" = "",
    "3" = "",
    "4" = ""
  }

  name                = "nic-${each.key}"
  location            = azurerm_resource_group.detail.location
  resource_group_name = azurerm_resource_group.detail.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.detail.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "detail" {
  for_each = {
    "1" = {
      name              = "public-ip-1"
      allocation_method = "Static"
    },
    "2" = {
      name              = "public-ip-2"
      allocation_method = "Dynamic"
    },
    "3" = {
      name              = "public-ip-3"
      allocation_method = "Static"
    },
    "4" = {
      name              = "public-ip-4"
      allocation_method = "Dynamic"
    }
  }

  name                = each.value.name
  location            = azurerm_resource_group.detail.location
  resource_group_name = azurerm_resource_group.detail.name
  allocation_method   = each.value.allocation_method

  tags = {
    environment = "development"
  }
}

resource "azurerm_subnet" "detail" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.detail.name
  virtual_network_name = azurerm_virtual_network.detail.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network" "detail" {
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.detail.location
  resource_group_name = azurerm_resource_group.detail.name
}

resource "azurerm_resource_group" "detail" {
  name     = "vm-infrastructure"
  location = "Southeast Asia"
}
