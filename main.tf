# Terraform backend configuration for remote state file
# update key for your specific deployment
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.78.0"
    }
  }
  backend "azurerm" {
    subscription_id = "ae68a9a2-abf6-4202-a22c-fc94bfad4d00"
    resource_group_name = "rg-prd-deployments-we-01"
    storage_account_name = "saprdcretfstatewe01"
    container_name = "tfstates"
    key = "LZ-management.tfstate" 
  }
}

# defintion of the Azure provider version
provider "azurerm" {
  features {}
}

#define inputs
variable "spec" {
  description = "definition for the deployment"
}
variable "secrets" {
  description = "secrets!"
  default     = {}
}

# call to custom terraform module
module "deployment" {
  # module source (use tagged version controlled reference for preference)
  #source = "git::ssh://git@innersource.accenture.com/iasc/terraform-azurerm-iaas_deployment.git?ref=vN.N.N"
  source = "../../"

  # module input variables
  spec    = var.spec
  secrets = var.secrets
}

output "module" {
  value = module.deployment
}