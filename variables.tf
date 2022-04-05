#Variables infrastructure

#Standards variables 

variable "location" {
    type = string
    description = "la région pour le déploiement de ressources"
    
}

variable "tags" {
  type        = map(string)
  description = "Tags pour le déploiement de ressources"
 
}
##############################################################################################################

##cntivité
variable "rg_cnt" {
    type = string
    description = "le nom de ressource groupe connecitivité"
    
}

#variable "vnet_name_cnt" {
#  type        = string
#  description = "le nom de réseau virtual cntivité"
#  
#}

variable "vnet_address_space_cnt" {
  type        = list(any)
  description = "Espace d adressage cntivité"
 
}

variable "address_prefixes_gateway_cnt" {
  type        = list(any)
  description = " préfixe d adresse du gateway pour la cntivité "
  
}

variable "address_prefixes_firewall_cnt" {
  type        = list(any)
  description = "préfixe d adresse du firewall pour la cntivité "
  
}

#variable "networkwatcher_cnt" {
#  type        = string
#  description = "le nom d observateur réseau cntivité"
#  
#}


##############################################################################################################

##Identité
variable "rg_idt" {
    type = string
    description = "le nom de ressource groupe identité"
  }

variable "vnet_name_idt" {
  description = "le nom de réseau virtual identité"
  type        = string
 
}

variable "address_spaces_idt" {
  description = "Espace d adressage identité "
  type        = list(string)
  default     = []
}

variable "subnet_prefixes_idt" {
  description = "préfixe d adresse pour l identité "
  type        = list(string)
  
}

variable "subnet_names_idt" {
  description = "le nom de sous réseau identié "
  type        = string
  
}

#variable "networkwatcher_idt" {
#  type        = string
#  description = "le nom d observateur réseau identié"
#}