#create a file nic.tf copy line 3 till 15
  
resource "azurerm_network_interface" "web_nic" {
  name = "${local.name_prefix}-${var.resource_group_name}-nic"
  #this vnet need location and resource group
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
 #nic is something called as ip configuration
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web-subnet.id #this will allocate private ip 
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id =  azurerm_public_ip.web_vm_publicip.id
  }
}

#inside your resource group you will see the nic card
  #validate
  1. nic has public and private ip 
  ##lets see the graph run a command
  terraform graph
  ##whatever output you will get copy everthing from digraph till end curl braces then open this site in a browser and delete everything on right side and paste the outpout 
  https://dreampuf.github.io/GraphvizOnline
