##create a new file vm.tf copy line 2 till 32
  resource "azurerm_linux_virtual_machine" "web-vm" {
  name = "${local.name_prefix}-${var.resource_group_name}-web-vm"
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  size                = "Standard_D2nlds_v6"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
    #this is an pre-define meta argument in terraform path.module will always look for the file in current directory 
    #public_key = file("C:\Users\gopal\OneDrive\Desktop\terraform-project\ssh-keys\terraform-azure.pem")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app.sh")
}

#next we need to verify the
  1. once create you will get an public ip copy that and paste it in the browser check that there is no https you will see the test page
  2. lets login inside the instane 
  cd .\ssh-keys\      
  #change the public ip with yoru public ip
  ssh -i .\terraform-azure.pem azureuser@20.115.30.231          
  exit
  cd ..
  ###########this verify that your vm is connected to the outside network
  terraform graph
  ##copy the code and paste it in dreampuff
  https://dreampuf.github.io/GraphvizOnline/
  #verify the vm connection with nic
  39 cd ..   
