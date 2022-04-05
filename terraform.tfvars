#Variables infrastructure

#######Standards
location = "Canada Central"
tags = {
    
    "Owner"       = "Fondation"
  }


##Connectivité
rg_cnt  = "cnt" 
vnet_name_cn = "cnt-vnet-mfq"
vnet_address_space_cnt = ["10.0.0.0/16"]
address_prefixes_gateway_cnt = ["10.0.1.0/27"]
address_prefixes_firewall_cnt = ["10.0.254.0/26"]

#networkwatcher_cn = "cnt-netwatcher"

##identité
rg_idt  = "idt" 
vnet_name_idt = "vnet-mfq-idt"
address_spaces_idt = ["11.0.0.0/24"]
subnet_prefixes_idt = ["11.0.0.0/26"]
subnet_names_idt = "Subidt"

#networkwatcher_idt = "idt-netwatcher"
